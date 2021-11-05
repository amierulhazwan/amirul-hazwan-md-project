import 'package:flutter/material.dart';
import 'package:md_project/widgets/header.dart';
import 'package:md_project/widgets/progress.dart';

class Timeline extends StatefulWidget {
  const Timeline({Key? key}) : super(key: key);

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true, titleText: ''),
      body: circularProgress(),
    );
  }
}
