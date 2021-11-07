import 'package:flutter/material.dart';
import 'package:md_project/pages/editprofile.dart';
import 'package:md_project/widgets/header.dart';
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

  // Container buildButton({required String text, required Function function}) {
  //   return Container(
  //     padding: const EdgeInsets.only(top: 2.0),
  //     child: TextButton(
  //       onPressed: function(),
  //       child: Container(
  //         width: 250.0,
  //         height: 27.0,
  //         child: Text(
  //           text,
  //           style: const TextStyle(
  //             color: Colors.white,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         alignment: Alignment.center,
  //         decoration: const BoxDecoration(
  //           color: Colors.blue,
  //         ),
  //       ),
  //       style: TextButton.styleFrom(
  //         shape: const BeveledRectangleBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(5))),
  //       ),
  //     ),
  //   );
  // }

  editProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfile(),
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
              builder: (context) => EditProfile(),
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
                      image: NetworkImage(
                          'https://cdn1.iconfinder.com/data/icons/robots-avatars-set/354/Cute_robot___robot_robo_cute_cyborg-512.png'),
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
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 4.0),
          )
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: header(context, titleText: "Profile"),
        body: ListView(
          children: <Widget>[buildProfileHeader()],
        ));
  }
}
