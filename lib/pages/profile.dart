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
  Column buildCountColumn(String label, String count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count.toString(),
          style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
        ),
        Container(
          child: Text(
            label,
            style: const TextStyle(
                color: Colors.white,
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
      padding: const EdgeInsets.only(top: 2.0),
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(horizontal: 30, vertical: 0)),
          backgroundColor: MaterialStateProperty.all(Colors.brown[50]),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              // side: const BorderSide(color: Colors.grey),
            ),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EditProfile(),
            ),
          );
        },
        child: Container(
          width: 150.0,
          height: 25.0,
          child: const Text(
            'Edit Profile',
            style: TextStyle(
              color: Colors.black,
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
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.red[200],
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              offset: Offset(0, 5),
              blurRadius: 8.0,
            ),
          ],
        ),
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
                          buildCountColumn('post', '4'),
                          buildCountColumn('followers', '4,345'),
                          buildCountColumn('following', '2M'),
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
                'Hyun Bin',
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
                'Hottest Male on Earth!',
                style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    // fontSize: 16.0,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: header(context, titleText: "Profile"),
        body: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/bg.jpg"), fit: BoxFit.cover),
          ),
          child: ListView(
            children: <Widget>[
              buildProfileHeader(),
              const Divider(
                height: 0.0,
              ),
              postingCard(context,
                  date: '20.12.12',
                  imgAsset: 'assets/hb1.jpg',
                  desCription:
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                  numCom: '123',
                  numLike: '23,432'),
              postingCard(context,
                  date: '20.12.42',
                  imgAsset: 'assets/hb2.jpg',
                  desCription:
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                  numCom: '464',
                  numLike: '23,345'),
              postingCard(context,
                  date: '20.12.32',
                  imgAsset: 'assets/hb3.jpg',
                  desCription:
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                  numCom: '546',
                  numLike: '75,756'),
              postingCard(context,
                  date: '20.32.42',
                  imgAsset: 'assets/hb4.jpg',
                  desCription:
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                  numCom: '434',
                  numLike: '86,978'),
            ],
          ),
        ));
  }
}
