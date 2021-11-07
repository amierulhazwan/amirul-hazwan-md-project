// ignore_for_file: avoid_print, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Search extends StatefulWidget {
  const Search({Key? key, required this.channel, required this.stream})
      : super(key: key);
  final WebSocketChannel channel;
  final Stream stream;

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  AppBar buildSearchField() {
    return AppBar(
      elevation: 8.0,
      toolbarHeight: 90,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
      ),
      title: TextFormField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide:
                const BorderSide(color: Colors.white, style: BorderStyle.none),
          ),
          hintText: 'Search for user...',
          filled: true,
          prefixIcon: const Icon(
            Icons.account_box,
            size: 28.0,
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => print('Cleared'),
          ),
        ),
      ),
    );
  }

  Container buildNoContent() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 60.0),
      alignment: Alignment.center,
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.brown[50],
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
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
            const SizedBox(height: 20),
            const Text(
              'Find Users',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                // fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
                fontSize: 30.0,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildSearchField(),
      body: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/bg.jpg"), fit: BoxFit.cover),
          ),
          child: buildNoContent()),
    );
  }
}

class UserResult extends StatelessWidget {
  const UserResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text("User Result");
  }
}
