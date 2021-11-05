import 'dart:convert';

import 'package:flutter/material.dart';
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
    channel.sink.close();
    super.dispose();
  }

  dynamic decodedPost;
  // ignore: non_constant_identifier_names
  List ListPost = [];

  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true, titleText: ''),
      // body: circularProgress(),
      body: ListView.builder(
        // ignore: unnecessary_null_comparison
        itemCount: ListPost.length,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      //image
                      Container(
                          margin: const EdgeInsets.only(right: 30, left: 8),
                          child: Center(
                              child: Image.network(
                                  '${ListPost[index]["image"]}',
                                  errorBuilder: (_, _1, _2) =>
                                      const SizedBox.shrink()))),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              ListPost[index]["author"],
                              style: const TextStyle(fontSize: 23),
                            ),
                            Container(
                                margin: const EdgeInsets.fromLTRB(0, 13, 0, 13),
                                child: Text(
                                  ListPost[index]["date"],
                                  style: const TextStyle(fontSize: 15),
                                )),
                            Text("${ListPost[index]["description"]}")
                          ],
                        ),
                      ),
                      // ignore: avoid_unnecessary_containers
                      Container(
                        child: Row(
                          children: [
                            IconButton(
                                iconSize: 40,
                                onPressed: () {},
                                icon: const Icon(Icons.delete)),
                            IconButton(
                                color: Colors.pink,
                                iconSize: 40,
                                onPressed: () {},
                                icon: const Icon(Icons.favorite)),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
