import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ActivityFeed extends StatefulWidget {
  const ActivityFeed({Key? key, required this.channel, required this.stream})
      : super(key: key);
  final WebSocketChannel channel;
  final Stream stream;

  @override
  _ActivityFeedState createState() => _ActivityFeedState();
}

class _ActivityFeedState extends State<ActivityFeed> {
  final channel =
      WebSocketChannel.connect(Uri.parse('ws://besquare-demo.herokuapp.com'));
  late Stream stream;

  @override
  void initState() {
    stream = widget.channel.stream.asBroadcastStream();
    super.initState();
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text('Activity Feed');
  }
}

class ActivityFeedItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Activity Feed Item');
  }
}
