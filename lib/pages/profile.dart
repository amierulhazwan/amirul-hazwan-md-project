import 'package:flutter/material.dart';
import 'package:md_project/widgets/header.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, required this.channel}) : super(key: key);
  final WebSocketChannel channel;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, titleText: "Profile"),
      body: const Text("Profile"),
    );
  }
}
