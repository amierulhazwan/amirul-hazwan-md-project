// ignore_for_file: avoid_print, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class PostingPage extends StatefulWidget {
  const PostingPage({Key? key, required this.channel, required this.stream})
      : super(key: key);
  final WebSocketChannel channel;
  final Stream stream;
  @override
  State<PostingPage> createState() => _PostingPageState();
}

class _PostingPageState extends State<PostingPage> {
  final channel =
      WebSocketChannel.connect(Uri.parse('ws://besquare-demo.herokuapp.com'));
  late Stream stream;

  @override
  void initState() {
    stream = widget.channel.stream.asBroadcastStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Center(
          child: Text(
            'Caption Post',
            style: TextStyle(color: Colors.black),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Post',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(color: Colors.red),
            ),
            height: 280.0,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.transparent)),
                onPressed: null,
                icon: const Icon(
                  Icons.cloud_upload_sharp,
                  color: Colors.black,
                  size: 30,
                ),
                label: const Text(
                  'Upload Image',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
          ),
          ListTile(
            leading: Container(
              width: 60.0,
              height: 60.0,
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
                    width: 60.0,
                    height: 60.0,
                    image: AssetImage('assets/profile_picture.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            title: Container(
              width: 250.0,
              child: const TextField(
                decoration: InputDecoration(
                  hintText: ('Write a description..'),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 2.0,
          ),
          const Divider(
            color: Colors.grey,
          ),
          Container(
            margin: const EdgeInsets.only(left: 15),
            child: ListTile(
              leading: const Icon(
                Icons.tag_outlined,
                color: Colors.red,
                size: 35.0,
              ),
              title: Container(
                width: 250.0,
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Image Title',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15),
            child: ListTile(
              leading: const Icon(
                Icons.image,
                color: Colors.red,
                size: 35.0,
              ),
              title: Container(
                width: 250.0,
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Image URL',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 200.0,
            height: 100.0,
            alignment: Alignment.center,
            child: ElevatedButton.icon(
              onPressed: () => print('get user location'),
              icon: const Icon(
                Icons.my_location,
                color: Colors.white,
              ),
              label: const Text(
                'Use Current Location',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
