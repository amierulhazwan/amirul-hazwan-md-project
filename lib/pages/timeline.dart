// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:md_project/cubit/maincubit.dart';
import 'package:md_project/pages/about.dart';
import 'package:md_project/pages/favourite.dart';
import 'package:md_project/pages/upload.dart';
import 'package:md_project/pages/viewpostscreen.dart';
import 'package:web_socket_channel/io.dart';
// import 'package:md_project/widgets/header.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'loginpage.dart';

class Timeline extends StatefulWidget {
  const Timeline({
    Key? key,
    required this.channel,
    required this.stream,
  }) : super(key: key);
  final WebSocketChannel channel;
  final Stream stream;

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  List posts = [];
  List favoritePosts = [];
  // bool isFavorite = false;
  bool favouriteClicked = false;
  final postName = TextEditingController();
  final channel =
      WebSocketChannel.connect(Uri.parse('ws://besquare-demo.herokuapp.com'));
  late Stream stream;

  // ignore: annotate_overrides
  initState() {
    super.initState();
    stream = widget.channel.stream.asBroadcastStream();
    widget.channel.stream.listen((results) {
      final decodedPost = jsonDecode(results);
      if (decodedPost['type'] == 'all_posts') {
        posts = decodedPost['data']['posts'];
        print(posts);
      }
      setState(() {});
    });
    getPosts();
  }

  void getPosts() {
    channel.stream.listen((message) {
      final decodedMessage = jsonDecode(message);
      setState(() {
        posts = decodedMessage['data']['posts'];
      });
      channel.sink.close();
    });

    channel.sink.add('{"type": "get_posts"}');
  }

  sortDate() {
    for (int i = 0; i >= posts.length; i++) {}
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  Container titleSection(index) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        '${posts[index]["title"].toString().characters.take(20)}',
        style: TextStyle(fontWeight: FontWeight.bold),
        softWrap: true,
      ),
    );
  }

  Container textSection(index) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        '"${posts[index]["description"]}"',
        softWrap: true,
      ),
    );
  }

  void deletePost(postID, name) {
    try {
      final channel =
          IOWebSocketChannel.connect('ws://besquare-demo.herokuapp.com');

      channel.sink.add('{"type": "sign_in", "data": {"name": "$name"}}');

      channel.sink.add('{"type":"delete_post","data":{"postId":"$postID"}}');
    } catch (e) {
      // Catch error if you are not the owner of the post
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 50),
                height: 200,
                color: Colors.white,
                child: Image.asset(
                  'assets/icon.png',
                  width: 300,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AboutApp(),
                        ),
                      );
                    },
                    child: const Text(
                      'About',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20.0,
                      ),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10)),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.red[100]),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(
                            title: 'Login Page',
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.red,
                      size: 30,
                    ),
                    label: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.red, fontSize: 20.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          elevation: 8.0,
          toolbarHeight: 60,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Favorite(favoritePost: favoritePosts),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.tag_faces_rounded,
                  size: 30,
                )),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Upload(
                      channel: channel,
                      stream: stream,
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.camera_enhance,
                size: 30.0,
              ),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return BlocProvider(
                        create: (context) => MainCubit(),
                        child: BlocBuilder<MainCubit, String>(
                          builder: (context, state) {
                            return AlertDialog(
                              title: const Text("Information"),
                              content: Text("Hold a post to delete the post"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Ok"),
                                )
                              ],
                            );
                          },
                        ),
                      );
                    });
              },
              icon: const Icon(
                Icons.info_rounded,
                size: 30,
              ),
            ),
          ],
          title: const Center(
            child: Text(
              'BeSquareGram',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/bg.jpg"), fit: BoxFit.cover),
          ),
          child: ListView.builder(
            // ignore: unnecessary_null_comparison
            itemCount: posts == null ? 0 : posts.length,
            itemBuilder: (context, index) {
              bool isFavourite = favoritePosts.contains(posts[index]);

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Container(
                  width: double.infinity,
                  // height: 690.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black45,
                        offset: Offset(0, 5),
                        blurRadius: 8.0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              leading: Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black54,
                                      offset: Offset(0, 2),
                                      blurRadius: 6.0,
                                    )
                                  ],
                                ),
                                child: CircleAvatar(
                                  backgroundColor: Colors.red[100],
                                  child: const ClipOval(
                                    child: Image(
                                      width: 50.0,
                                      height: 50.0,
                                      image: NetworkImage(
                                          'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                '${posts[index]["author"].toString().characters.take(20)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              subtitle: Text(
                                'Posted on ${posts[index]["date"].toString().characters.take(10)}',
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.more_horiz),
                                color: Colors.red,
                                onPressed: () => print('More'),
                              ),
                            ),
                            InkWell(
                              onLongPress: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return BlocProvider(
                                        create: (context) => MainCubit(),
                                        child: BlocBuilder<MainCubit, String>(
                                          builder: (context, state) {
                                            return AlertDialog(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0),
                                                ),
                                              ),
                                              title: const Text("Delete Post"),
                                              content: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,

                                                // ignore: prefer_const_literals_to_create_immutables
                                                children: [
                                                  const Text(
                                                      "Do you want to delete this post?"),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          deletePost(
                                                              '${posts[index]['_id']}',
                                                              postName.text);
                                                          Navigator.of(context)
                                                              .pop();
                                                        });
                                                      },
                                                      style: ButtonStyle(
                                                          padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(
                                                              horizontal: 30,
                                                              vertical: 10)),
                                                          backgroundColor: MaterialStateProperty.all(
                                                              Colors.brown[50]),
                                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          18.0)
                                                                  // side: const BorderSide(color: Colors.grey),
                                                                  ))),
                                                      child: const Text('Delete',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15.0))),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      style: ButtonStyle(
                                                          padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.symmetric(
                                                              horizontal: 30,
                                                              vertical: 10)),
                                                          backgroundColor: MaterialStateProperty.all(
                                                              Colors.brown[50]),
                                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          18.0)
                                                                  // side: const BorderSide(color: Colors.grey),
                                                                  ))),
                                                      child: const Text('Cancel',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15.0))),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    });
                              },
                              onDoubleTap: () => print('Like Post'),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewPostScreen(
                                      author: posts[index]['author'],
                                      title: posts[index]['title'],
                                      description: posts[index]['description'],
                                      img: posts[index]['image'],
                                      date: posts[index]['date'],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.all(10.0),
                                width: double.infinity,
                                height: 400.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0, 5),
                                      blurRadius: 8.0,
                                    ),
                                  ],
                                  image: DecorationImage(
                                    image: NetworkImage(Uri.parse(
                                                    posts[index]['image'])
                                                .isAbsolute &&
                                            posts[index].containsKey('image')
                                        ? '${posts[index]['image']}'
                                        : 'https://upload.wikimedia.org/wikipedia/commons/d/d1/Image_not_available.png'),
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(isFavourite
                                                ? Icons.favorite
                                                : Icons
                                                    .favorite_border_outlined),
                                            iconSize: 30.0,
                                            color: Colors.red,
                                            onPressed: () {
                                              setState(() {
                                                if (isFavourite) {
                                                  favoritePosts
                                                      .remove(posts[index]);
                                                } else {
                                                  favoritePosts
                                                      .add(posts[index]);
                                                }
                                              });
                                            },
                                          ),
                                          const Text(
                                            '2,123',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 20.0),
                                      Row(
                                        children: <Widget>[
                                          IconButton(
                                            icon: const Icon(Icons.chat),
                                            iconSize: 30.0,
                                            onPressed: () => {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ViewPostScreen(
                                                    author: posts[index]
                                                        ['author'],
                                                    title: posts[index]
                                                        ['title'],
                                                    description: posts[index]
                                                        ['description'],
                                                    img: posts[index]['image'],
                                                    date: posts[index]['date'],
                                                  ),
                                                ),
                                              ),
                                            },
                                          ),
                                          const Text(
                                            '350',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.bookmark_border),
                                    iconSize: 30.0,
                                    onPressed: () => print('Save Post'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 350,
                        padding: EdgeInsets.only(bottom: 10, left: 10),
                        // color: Colors.amber,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: titleSection(index),
                            ),
                            Container(
                              child: textSection(index),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
