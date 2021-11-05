import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Ni Supposedly be Post Page trial',
            ),
            Text(
              'POSTPAGE',
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const PostPage(title: 'Flutter Demo Home Page')));
              },
              child: const Text('WebSocket Trial'),
            ),
          ],
        ),
      ),
    );
  }
}
