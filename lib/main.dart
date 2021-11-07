import 'package:flutter/material.dart';
import 'frontpage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Colors.red[200],
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(primary: Colors.red[300], secondary: Colors.red),

        fontFamily: 'Georgia',
      ),
      home: const FrontPage(title: 'Login Page'),
    );
  }
}
