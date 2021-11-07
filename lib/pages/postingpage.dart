// import 'dart:html';

// ignore_for_file: sized_box_for_whitespace, avoid_print

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PostingPage extends StatefulWidget {
  const PostingPage({Key? key}) : super(key: key);

  @override
  State<PostingPage> createState() => _PostingPageState();
}

class _PostingPageState extends State<PostingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
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
            onPressed: () => print('Posting'),
            child: const Text(
              'Post',
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 220.0,
            width: MediaQuery.of(context).size.width * 0.8,
            child: const Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                // child: Container(
                //   decoration: DecorationImage(
                //     fit: BoxFit.cover,
                //     image: FileImage(file),
                //   ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10.0),
          ),
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
            title: Container(
              width: 250.0,
              child: const TextField(
                decoration: InputDecoration(
                  hintText: ('Write a caption..'),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Divider(),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: ListTile(
              leading: const Icon(
                Icons.pin_drop,
                color: Colors.blueAccent,
                size: 35.0,
              ),
              title: Container(
                width: 250.0,
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Where was this photo taken ?',
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
