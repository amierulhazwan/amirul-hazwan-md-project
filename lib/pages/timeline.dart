import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:md_project/pages/comments.dart';
import 'package:md_project/pages/viewpostscreen.dart';
import 'package:md_project/widgets/header.dart';
// import 'package:md_project/widgets/progress.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Timeline extends StatefulWidget {
  const Timeline({
    Key? key,
    required this.channel1,
    required this.stream,
  }) : super(key: key);
  final WebSocketChannel channel1;
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
    stream = widget.channel1.stream.asBroadcastStream();
    widget.channel1.stream.listen((results) {
      decodedPost = jsonDecode(results);
      if (decodedPost['type'] == 'all_posts') {
        ListPost = decodedPost['data']['posts'];
        // ignore: avoid_print
        print(ListPost);
      }
      setState(() {});
    });
    _getPosts();
  }

  void _getPosts() {
    widget.channel1.sink.add('{"type": "get_posts"}');
  }

  @override
  void dispose() {
    // channel.sink.close();
    super.dispose();
  }

  dynamic decodedPost;
  // ignore: non_constant_identifier_names
  List ListPost = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true, titleText: ''),
      body: ListView.builder(
        // ignore: unnecessary_null_comparison
        itemCount: ListPost == null ? 0 : ListPost.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Container(
              width: double.infinity,
              height: 560.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Container(
                            // margin: EdgeInsets.all(10.0),
                            width: 50.0,
                            height: 50.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black45,
                                  offset: Offset(0, 2),
                                  blurRadius: 6.0,
                                )
                              ],
                            ),
                            child: const CircleAvatar(
                              child: ClipOval(
                                child: Image(
                                  width: 50.0,
                                  height: 50.0,
                                  image: NetworkImage(
                                      'https://cdn1.iconfinder.com/data/icons/robots-avatars-set/354/Cute_robot___robot_robo_cute_cyborg-512.png'),
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
                            color: Colors.black,
                            onPressed: () => print('More'),
                          ),
                        ),
                        InkWell(
                          onDoubleTap: () => print('Like Post'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ViewPostScreen(
                                  post: ListPost[index]["image"],
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
                                  color: Colors.black45,
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
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                                              builder: (_) => ViewPostScreen(
                                                post: ListPost[index]["image"],
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
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );

// -----------------------------------------------------------------------------------------------------------
    // return Scaffold(
    //   appBar: header(context, isAppTitle: true, titleText: ''),
    //   body: ListView.builder(
    //     // ignore: unnecessary_null_comparison
    //     itemCount: ListPost == null ? 0 : ListPost.length,
    //     itemBuilder: (context, index) {
    //       return Card(
    //         elevation: 5,
    //         child: Padding(
    //           padding: const EdgeInsets.all(20),
    //           child: Column(
    //             children: <Widget>[
    //               Container(
    //                 margin: const EdgeInsets.only(right: 30, left: 8),
    //                 child: Center(
    //                   child: Image.network(
    //                     '${ListPost[index]["image"]}',
    //                     width: 260,
    //                     height: 260,
    //                     errorBuilder: (_, _1, _2) => const SizedBox.shrink(),
    //                   ),
    //                 ),
    //               ),
    //               Row(
    //                 children: [
    //                   Expanded(
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Container(
    //                           padding: const EdgeInsets.only(bottom: 8),
    //                           child: Text(
    //                             ListPost[index]["author"],
    //                             style: const TextStyle(
    //                                 fontWeight: FontWeight.bold, fontSize: 18),
    //                           ),
    //                         ),
    //                         Text(
    //                           ListPost[index]["date"],
    //                           style: const TextStyle(fontSize: 15),
    //                         )
    //                       ],
    //                     ),
    //                   ),
    //                   const Icon(Icons.star),
    //                 ],
    //               ),
    //               Container(
    //                 margin: const EdgeInsets.only(top: 10.0),
    //                 child: Text("${ListPost[index]["description"]}"),
    //               ),
    //             ],
    //           ),
    //         ),
    //       );
    //     },
    //   ),
    // );
// -----------------------------------------------------------------------------------------------------------
  }
}
