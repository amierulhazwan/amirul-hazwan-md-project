// ignore_for_file: avoid_print

import "package:flutter/material.dart";
import 'package:md_project/pages/loginpage.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final displayNameController = TextEditingController();
  final bioController = TextEditingController();
  bool _displayNameValid = true;
  bool _bioValid = true;

  Column buildDisplayNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            'Display Name',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          controller: displayNameController,
          decoration: InputDecoration(
              hintText: 'Update Display Name',
              errorText:
                  _displayNameValid ? null : 'Display Name is too short.'),
        )
      ],
    );
  }

  Column buildBioField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            'Bio',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          controller: bioController,
          decoration: InputDecoration(
              hintText: 'Update Bio',
              errorText: _bioValid ? null : 'Bio is too long.'),
        ),
      ],
    );
  }

  updateProfileData() {
    setState(
      () {
        displayNameController.text.trim().length < 3 ||
                displayNameController.text.isEmpty
            ? _displayNameValid = false
            : _displayNameValid = true;

        bioController.text.trim().length > 100
            ? _bioValid = false
            : _bioValid = true;
      },
    );

    if (_displayNameValid && _bioValid) {
      print('Profile Data Update');
    }
    // SnackBar snackBar = const SnackBar(content: Text('Profile Updated'));
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Profile is Updated.')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.done,
              size: 30.0,
              color: Colors.green,
            ),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 40.0, bottom: 8.0),
                child: Container(
                  // margin: EdgeInsets.all(10.0),
                  width: 120.0,
                  height: 120.0,
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
                        width: 120.0,
                        height: 120.0,
                        image: NetworkImage(
                            'https://cdn1.iconfinder.com/data/icons/robots-avatars-set/354/Cute_robot___robot_robo_cute_cyborg-512.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    buildDisplayNameField(),
                    buildBioField(),
                  ],
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Column(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () => updateProfileData(),
                    child: const Text(
                      'Update Profile',
                      style: TextStyle(
                        // color: Theme.of(context).primaryColor,
                        color: Colors.white,
                        fontSize: 20.0,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(
                              title: 'Login Page',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.cancel,
                        color: Colors.red,
                      ),
                      label: const Text(
                        'Logout',
                        style: TextStyle(color: Colors.red, fontSize: 20.0),
                      )),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
