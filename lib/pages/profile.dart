// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:md_project/pages/editprofile.dart';
import 'package:md_project/widgets/header.dart';
import 'package:md_project/widgets/post.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, required this.channel, required this.stream})
      : super(key: key);
  final WebSocketChannel channel;
  final Stream stream;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Column buildCountColumn(String label, int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count.toString(),
          style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4.0),
          child: Text(
            label,
            style: const TextStyle(
                color: Colors.grey,
                fontSize: 15.0,
                fontWeight: FontWeight.w400),
          ),
        )
      ],
    );
  }

  editProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EditProfile(),
      ),
    );
  }

  Container buildProfileButton() {
    return Container(
      margin: const EdgeInsets.only(top: 2),
      padding: const EdgeInsets.only(top: 2.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EditProfile(),
            ),
          );
        },
        child: Container(
          width: 200.0,
          height: 25.0,
          child: const Text(
            'Edit Profile',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          alignment: Alignment.center,
        ),
      ),
    );
  }

  buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 90.0,
                height: 90.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    )
                  ],
                ),
                child: const CircleAvatar(
                  child: ClipOval(
                    child: Image(
                      width: 90.0,
                      height: 90.0,
                      image: AssetImage('assets/profile_picture.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        buildCountColumn('post', 0),
                        buildCountColumn('followers', 0),
                        buildCountColumn('following', 0),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        buildProfileButton(),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 12.0),
            child: const Text(
              'Username',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 4.0),
            child: const Text(
              'Display Name',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                // fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: header(context, titleText: "Profile"),
        body: ListView(
          children: <Widget>[
            buildProfileHeader(),
            const Divider(
              height: 0.0,
            ),
            postingCard(context,
                date: '20.12.12',
                imgAsset: 'assets/hb1.jpg',
                comMent: '',
                numCom: '',
                numLike: ''),
            postingCard(context,
                date: '20.12.42',
                imgAsset: 'assets/hb2.jpg',
                comMent: '',
                numCom: '',
                numLike: ''),
            postingCard(context,
                date: '20.12.32',
                imgAsset: 'assets/hb3.jpg',
                comMent: '',
                numCom: '',
                numLike: ''),
            postingCard(context,
                date: '20.32.42',
                imgAsset: 'assets/hb4.jpg',
                comMent: '',
                numCom: '',
                numLike: ''),
          ],
        ));
  }
}
