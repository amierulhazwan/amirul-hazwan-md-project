import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Search extends StatefulWidget {
  const Search({Key? key, required this.channel}) : super(key: key);
  final WebSocketChannel channel;

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Text('Search');
  }
}

class UserResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("User Result");
  }
}
