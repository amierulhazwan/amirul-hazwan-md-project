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
        centerTitle: true,
        elevation: 8.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.brown[50],
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.black, fontSize: 25.0),
        ),
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg.jpg"), fit: BoxFit.cover),
        ),
        child: Center(
          child: SizedBox(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 30),
                const Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                TextField(
                  autofocus: false,
                  style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                  controller: userNameController,
                  onSubmitted: (_) => submitData,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.brown[50],
                    hintText: 'Username',
                    hintStyle: const TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                    contentPadding: const EdgeInsets.only(
                        left: 30.0, bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10)),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.brown[50]),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        // side: const BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
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
      ),
    );
  }
}
