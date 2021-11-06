// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:web_socket_channel/io.dart';
import '../home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
// ------------------------------------------------------------
  final userNameController = TextEditingController();
  final userPswd = TextEditingController();
  bool _isOff = true;

  final channel =
      WebSocketChannel.connect(Uri.parse('ws://besquare-demo.herokuapp.com'));

  // void listenStream() {
  //   channel.stream.listen((message) {
  //     final decodedMessage = jsonDecode(message);
  //   });
  // }

  void submitData() {
    setState(() {
      final String inputUserName = userNameController.text;
      channel.sink.add('{"type": "sign_in","data":{"name": "$inputUserName"}}');
      if (inputUserName.isEmpty) {
        _isOff = true;
      } else {
        _isOff = false;
      }
    });
  }

  void checkInput() {
    setState(() {
      final String inputPswd = userPswd.text;
      if (inputPswd.isEmpty) {
        _isOff = true;
      } else {
        _isOff = false;
      }
    });
  }

// -----------------------------------------------------------^^^^^^
  @override
  void initState() {
    // -------------------------------------------------------
    userNameController.addListener(submitData);
    // -------------------------------------------------------^^^^^^
    super.initState();
  }

// -----------------------------------------------------------
  @override
  void dispose() {
    userNameController.dispose();
    // channel.sink.close();
    super.dispose();
  }
  // -----------------------------------------------------------^^^^^^

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
              TextField(
                controller: userNameController,
                onSubmitted: (_) => submitData,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: userPswd,
                onSubmitted: (_) => checkInput(),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Password'),
              ),
              const SizedBox(height: 20),
              // StreamBuilder(
              //     stream: channel.stream,
              //     builder: (context, snapshot) {
              //       return Padding(
              //         padding: const EdgeInsets.all(20.0),
              //         child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
              //       );
              //     }),
              // const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Login'),
                onPressed: !_isOff
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(
                              title: 'BeSquare Gram',
                              channel1: channel,
                              channel2: channel,
                              channel3: channel,
                              channel4: channel,
                              channel5: channel,
                            ),
                          ),
                        );
                      }
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
