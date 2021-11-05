import 'package:flutter/material.dart';
import 'pages/loginpage.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // const Text(
            //   'DerivGram',
            // ),
            Text(
              'BeSquareGram',
              style: Theme.of(context).textTheme.headline4,
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const LoginPage(title: 'Login Page')));
                },
                child: const Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
