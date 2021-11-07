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
  // late File file;

  // handleTakePhoto() async {
  //   Navigator.pop(context);
  //   File file;
  //   await ImagePicker.pickImage(
  //     source: ImageSource.camera,
  //     maxHeight: 675,
  //     maxWidth: 960,
  //   );
  //   setState(() {
  //     this.file = file;
  //   });
  // }

  // handleChooseFromGallery() async {
  //   Navigator.pop(context);
  //   File file;
  //   await ImagePicker.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     this.file = file;
  //   });
  // }

  selectImage(parentContext) {
    return showDialog(
      context: parentContext,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Create Post'),
          children: <Widget>[
            // SimpleDialogOption(
            //     child: const Text('Photo with Camera'),
            //     onPressed: () => Navigator.pop(context),
            SimpleDialogOption(
              child: const Text('Image from Gallery'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PostingPage(),
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
          const Image(
            image: AssetImage('assets/icon.png'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: ElevatedButton(
              onPressed: () => selectImage(context),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              child: const Text(
                'Upload Image',
                style: TextStyle(color: Colors.white, fontSize: 22.0),
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
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.6),
      body: Center(
        child: buildSplashScreen(),
      ),
    );
  }
}
