// import 'dart:developer';

// ignore_for_file: deprecated_member_use, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// import 'pages/favourite.dart';
import 'pages/profile.dart';
import 'pages/search.dart';
import 'pages/timeline.dart';
import 'pages/upload.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {Key? key,
      required this.title,
      required this.channel1,
      // required this.channel2,
      required this.channel3,
      required this.channel4,
      required this.channel5})
      : super(key: key);
  final String title;
  final WebSocketChannel channel1;
  // final WebSocketChannel channel2;
  final WebSocketChannel channel3;
  final WebSocketChannel channel4;
  final WebSocketChannel channel5;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final channel1 =
      WebSocketChannel.connect(Uri.parse('ws://besquare-demo.herokuapp.com'));
  // final channel2 =
  //     WebSocketChannel.connect(Uri.parse('ws://besquare-demo.herokuapp.com'));
  final channel3 =
      WebSocketChannel.connect(Uri.parse('ws://besquare-demo.herokuapp.com'));
  final channel4 =
      WebSocketChannel.connect(Uri.parse('ws://besquare-demo.herokuapp.com'));
  final channel5 =
      WebSocketChannel.connect(Uri.parse('ws://besquare-demo.herokuapp.com'));
  late Stream stream1;
  // late Stream stream2;
  late Stream stream3;
  late Stream stream4;
  late Stream stream5;
  late PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    pageController = PageController();
    stream1 = widget.channel1.stream.asBroadcastStream();
    // stream2 = widget.channel2.stream.asBroadcastStream();
    stream3 = widget.channel3.stream.asBroadcastStream();
    stream4 = widget.channel4.stream.asBroadcastStream();
    stream5 = widget.channel5.stream.asBroadcastStream();
    super.initState();
  }

  @override
  void dispose() {
    // pageController.dispose();
    // widget.channel1.sink.close();
    // widget.channel2.sink.close();
    // widget.channel3.sink.close();
    // widget.channel4.sink.close();
    // widget.channel5.sink.close();
    super.dispose();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
// -----------------------------------------------------------------------------------------------------------
      body: PageView(
        children: <Widget>[
          Timeline(channel: channel1, stream: stream1),
          // Favorite(channel: channel2, stream: stream2),
          Upload(channel: channel3, stream: stream3),
          Search(channel: channel4, stream: stream4),
          Profile(channel: channel5, stream: stream5),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: Theme.of(context).primaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.favorite_border),
          // ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.camera_enhance,
              size: 35.0,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
          ),
        ],
      ),
// -----------------------------------------------------------------------------------------------------------

// -----------------------------------------------------------------------------------------------------------
    );
  }
}
