import 'package:flutter/material.dart';

AppBar header(context, {bool isAppTitle = false, required String titleText}) {
  return AppBar(
    title: Text(
      isAppTitle ? "BeSquare Gram" : titleText,
      style: const TextStyle(color: Colors.white, fontSize: 30.0),
    ),
    // Refer https://www.youtube.com/watch?v=7yG4IkF_sGg
    centerTitle: true,
    backgroundColor: Theme.of(context).accentColor,
  );
}
