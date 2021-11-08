// import 'dart:io';

// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:md_project/pages/postingpage.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key, required this.channel, required this.stream})
      : super(key: key);
  final WebSocketChannel channel;
  final Stream stream;

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  final channel =
      WebSocketChannel.connect(Uri.parse('ws://besquare-demo.herokuapp.com'));
  late Stream stream;

  @override
  void initState() {
    stream = widget.channel.stream.asBroadcastStream();
    super.initState();
  }

  selectImage(parentContext) {
    return showDialog(
      context: parentContext,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Upload'),
          children: <Widget>[
            // SimpleDialogOption(
            //     child: const Text('Photo with Camera'),
            //     onPressed: () => Navigator.pop(context),
            SimpleDialogOption(
              child: const Text('Create New Post'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PostingPage(channel: channel, stream: stream),
                  ),
                );
              },
            ),
            SimpleDialogOption(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  Container buildSplashScreen() {
    return Container(
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.cancel_rounded,
              size: 50,
              color: Colors.red,
            ),
            label: const Text(
              'Cancel',
              style: TextStyle(
                fontSize: 20,
                color: Colors.red,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.brown[50],
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: const Image(
              image: AssetImage('assets/icon.png'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: ElevatedButton(
              onPressed: () => selectImage(context),
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10)),
                backgroundColor: MaterialStateProperty.all(Colors.brown[50]),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    // side: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              child: const Text(
                'Create New Post',
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).primaryColor.withOpacity(0.6),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg.jpg"), fit: BoxFit.cover),
        ),
        child: Center(
          child: buildSplashScreen(),
        ),
      ),
    );
  }
}
