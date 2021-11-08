// ignore_for_file: avoid_print, deprecated_member_use

// import 'dart:convert';

import 'package:flutter/material.dart';

class ViewPostScreen extends StatelessWidget {
  const ViewPostScreen({
    Key? key,
    required this.title,
    required this.description,
    required this.img,
    required this.author,
    required this.date,
  }) : super(key: key);

  final String title;
  final String description;
  final String img;
  final String author;
  final String date;

// -----------------------------------------------------------------------------------------------------------
  Widget _buildComment() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: ListTile(
        leading: Container(
          width: 50.0,
          height: 50.0,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                offset: Offset(0, 2),
                blurRadius: 6.0,
              )
            ],
          ),
          child: CircleAvatar(
            backgroundColor: Colors.red[100],
            child: const ClipOval(
              child: Image(
                width: 50.0,
                height: 50.0,
                image: NetworkImage(
                    'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        title: const Text(
          'Author Name',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: const Text(
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.favorite_border,
          ),
          color: Colors.grey,
          onPressed: () => print('Like comment'),
        ),
      ),
    );
  }

// -----------------------------------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg.jpg"), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 20.0),
                width: double.infinity,
                // height: 580.0,
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    )
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(Icons.arrow_back),
                                iconSize: 30.0,
                                color: Colors.black,
                                onPressed: () => Navigator.pop(context),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: ListTile(
                                  leading: Container(
                                    // margin: EdgeInsets.all(10.0),
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black54,
                                          offset: Offset(0, 2),
                                          blurRadius: 6.0,
                                        )
                                      ],
                                    ),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.red[100],
                                      child: const ClipOval(
                                        child: Image(
                                          width: 50.0,
                                          height: 50.0,
                                          image: NetworkImage(
                                              'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    // ListPost[index]["author"],
                                    author,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${date.substring(0, 10)}',
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.more_horiz),
                                    color: Colors.red,
                                    onPressed: () => print('More'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onDoubleTap: () => print('Like Post'),
                            child: Container(
                              margin: const EdgeInsets.all(10.0),
                              width: double.infinity,
                              height: 400.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0, 5),
                                    blurRadius: 8.0,
                                  ),
                                ],
                                image: DecorationImage(
                                  image: NetworkImage(Uri.parse(img).isAbsolute
                                      ? img
                                      : 'https://upload.wikimedia.org/wikipedia/commons/d/d1/Image_not_available.png'),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        IconButton(
                                          icon: const Icon(
                                              Icons.favorite_border_outlined),
                                          iconSize: 30.0,
                                          color: Colors.red,
                                          onPressed: () => print('Like Post'),
                                        ),
                                        const Text(
                                          '2,123',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 20.0),
                                    Row(
                                      children: <Widget>[
                                        IconButton(
                                          icon: const Icon(Icons.chat),
                                          iconSize: 30.0,
                                          onPressed: () {
                                            print('Chat');
                                          },
                                        ),
                                        const Text(
                                          '350',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                IconButton(
                                  icon: const Icon(Icons.bookmark_border),
                                  iconSize: 30.0,
                                  onPressed: () => print('Save Post'),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 350,
                            padding: EdgeInsets.only(bottom: 5),
                            // color: Colors.amber,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    title,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    softWrap: true,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Text(
                                    description,
                                    softWrap: true,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0, 2),
                            blurRadius: 6.0,
                          )
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          _buildComment(),
                          _buildComment(),
                          _buildComment(),
                          _buildComment(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
// -----------------------------------------------------------------------------------------------------------
          // bottomNavigationBar: Transform.translate(
          //   offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
          //   child: Container(
          //     height: 80.0,
          //     decoration: const BoxDecoration(
          //       borderRadius: BorderRadius.only(
          //         topLeft: Radius.circular(30.0),
          //         topRight: Radius.circular(30.0),
          //       ),
          //       boxShadow: [
          //         BoxShadow(
          //           color: Colors.black12,
          //           offset: Offset(0, -2),
          //           blurRadius: 6.0,
          //         ),
          //       ],
          //       color: Colors.white,
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.all(12.0),
          //       child: TextField(
          //         decoration: InputDecoration(
          //           border: InputBorder.none,
          //           enabledBorder: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(30.0),
          //             borderSide: const BorderSide(
          //               color: Colors.grey,
          //             ),
          //           ),
          //           focusedBorder: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(30.0),
          //             borderSide: const BorderSide(
          //               color: Colors.grey,
          //             ),
          //           ),
          //           contentPadding: const EdgeInsets.only(
          //               left: 50.0, bottom: 8.0, top: 8.0),
          //           hintText: 'Add a comment',
          //           prefixIcon: Container(
          //             margin: const EdgeInsets.only(
          //                 top: 4.0, bottom: 4.0, left: 4.0, right: 15.0),
          //             width: 48.0,
          //             height: 48.0,
          //             decoration: const BoxDecoration(
          //               shape: BoxShape.circle,
          //               boxShadow: [
          //                 BoxShadow(
          //                   color: Colors.black45,
          //                   offset: Offset(0, 2),
          //                   blurRadius: 6.0,
          //                 )
          //               ],
          //             ),
          //             child: CircleAvatar(
          //               backgroundColor: Colors.red[100],
          //               child: const ClipOval(
          //                 child: Image(
          //                   width: 50.0,
          //                   height: 50.0,
          //                   image: NetworkImage(
          //                       'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png'),
          //                   fit: BoxFit.cover,
          //                 ),
          //               ),
          //             ),
          //           ),
          //           suffixIcon: Container(
          //             margin: const EdgeInsets.only(right: 4.0),
          //             width: 70.0,
          //             child: FlatButton(
          //               shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(30.0),
          //               ),
          //               color: Colors.red,
          //               onPressed: () => print('Post comment'),
          //               child: const Icon(
          //                 Icons.send,
          //                 size: 25.0,
          //                 color: Colors.white,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ),
      ),
    );
  }
}
