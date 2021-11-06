import 'package:flutter/material.dart';
import 'package:md_project/widgets/post.dart';

class ViewPostScreen extends StatefulWidget {
  final Post post;

  const ViewPostScreen({Key? key, required this.post}) : super(key: key);

  @override
  State<ViewPostScreen> createState() => _ViewPostScreenState();
}

class _ViewPostScreenState extends State<ViewPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Text("View Post Screen");
  }
}
