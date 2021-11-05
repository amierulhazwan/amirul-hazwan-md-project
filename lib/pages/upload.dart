import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key, required this.channel}) : super(key: key);
  final WebSocketChannel channel;

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  @override
  Widget build(BuildContext context) {
    return Text("Upload");
  }
}
