import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import '../home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
// ------------------------------------------------------------
  final channel =
      IOWebSocketChannel.connect(Uri.parse('ws://besquare-demo.herokuapp.com'));
  void listenStream() {
    channel.stream.listen((message) {
      final decodedMessage = jsonDecode(message);
    });
  }

  void submitData() {
    setState(() {
      final String enteredID = idController.text;
      channel.sink.add('{"type": "sign_in","data":{"name": "$enteredID"}}');
      if (enteredID.isEmpty) {
        _isOff = true;
      } else {
        _isOff = false;
      }
    });
  }

  final idController = TextEditingController();
  bool _isOff = true;
// -----------------------------------------------------------
  @override
  void initState() {
    // -----------------------------------------------------------
    idController.addListener(submitData);
    // -----------------------------------------------------------
    super.initState();
  }

  // -----------------------------------------------------------
  @override
  void dispose() {
    idController.dispose();
    channel.sink.close();
    super.dispose();
  }
  // -----------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Login',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 40),
              const TextField(
                // obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
              ),
              const SizedBox(height: 10),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const HomePage(title: 'BeSquare Gram')));
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
