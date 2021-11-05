// import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'pages/activityfeed.dart';
import 'pages/profile.dart';
import 'pages/search.dart';
import 'pages/timeline.dart';
import 'pages/upload.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {Key? key,
      required this.title,
      required this.channel1,
      required this.channel2})
      : super(key: key);
  final String title;
  final WebSocketChannel channel1;
  final WebSocketChannel channel2;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final channel1 =
      WebSocketChannel.connect(Uri.parse('ws://besquare-demo.herokuapp.com'));
  final channel2 =
      WebSocketChannel.connect(Uri.parse('ws://besquare-demo.herokuapp.com'));
  late Stream stream1;
  late Stream stream2;
  late PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    pageController = PageController();
    stream1 = widget.channel1.stream.asBroadcastStream();
    stream2 = widget.channel2.stream.asBroadcastStream();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    widget.channel1.sink.close();
    widget.channel2.sink.close();
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
      body: PageView(
        children: <Widget>[
          Timeline(channel1: channel1, stream: stream1),
          ActivityFeed(channel: channel2, stream: stream2),
          // Upload(channel: channel),
          // Search(channel: channel),
          // Profile(channel: channel),
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
            icon: Icon(Icons.whatshot),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.photo_camera,
              size: 35.0,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),
    );
  }
}
