// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:md_project/pages/viewpostscreen.dart';
import 'package:md_project/widgets/header.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

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
  final channel =
      WebSocketChannel.connect(Uri.parse('ws://besquare-demo.herokuapp.com'));
  late Stream stream;

  // ignore: annotate_overrides
  initState() {
    super.initState();
    stream = widget.channel.stream.asBroadcastStream();
    widget.channel.stream.listen((results) {
      decodedPost = jsonDecode(results);
      if (decodedPost['type'] == 'all_posts') {
        ListPost = decodedPost['data']['posts'];
        print(ListPost);
      }
      setState(() {});
    });
    _getPosts();
  }

  void _getPosts() {
    widget.channel.sink.add('{"type": "get_posts"}');
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  dynamic decodedPost;
  // ignore: non_constant_identifier_names
  List ListPost = [];

  Container textSection(index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        '"${ListPost[index]["description"]}"',
        softWrap: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: header(context, isAppTitle: true, titleText: ''),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg.jpg"), fit: BoxFit.cover),
        ),
        child: ListView.builder(
          // ignore: unnecessary_null_comparison
          itemCount: ListPost == null ? 0 : ListPost.length,
          itemBuilder: (context, index) {
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
                              ListPost[index]["author"],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            subtitle: Text(
                              ListPost[index]["date"],
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.more_horiz),
                              color: Colors.red,
                              onPressed: () => print('More'),
                            ),
                          ),
                          InkWell(
                            onDoubleTap: () => print('Like Post'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ViewPostScreen(),
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
                                  image: NetworkImage(
                                    '${ListPost[index]["image"]}',
                                  ),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        IconButton(
                                          icon: const Icon(
                                              Icons.favorite_border_outlined),
                                          iconSize: 30.0,
                                          color: Colors.red,
                                          onPressed: () => print('Like Post'),
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
                                                builder: (_) =>
                                                    const ViewPostScreen(
                                                        // id: ListPost[index]["_id"],
                                                        // channelvpc: channel,
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
                          Align(
                            alignment: Alignment.centerLeft,
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
    );
  }
}
