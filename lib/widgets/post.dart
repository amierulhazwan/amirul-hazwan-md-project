// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

Container postingCard(context,
    {required String date,
    required String imgAsset,
    required String desCription,
    required String numLike,
    required String numCom}) {
  String imgPath = imgAsset;
  String dateInput = date;
  String description = desCription;
  String likeNum = numLike;
  String comNum = numCom;

  Container textSection(context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        description,
        softWrap: true,
      ),
    );
  }

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
    padding: const EdgeInsets.only(top: 5.0),
    width: double.infinity,
    // height: 570.0,
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(
        Radius.circular(25.0),
      ),
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: ListTile(
                      leading: Container(
                        // margin: EdgeInsets.all(10.0),
                        width: 50.0,
                        height: 50.0,
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
                              width: 50.0,
                              height: 50.0,
                              image: AssetImage('assets/profile_picture.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      title: const Text(
                        // ListPost[index]["author"],
                        'Hyun Bin',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        // ListPost[index]["date"],
                        dateInput,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.more_horiz),
                        color: Colors.black,
                        onPressed: () => print('More'),
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onDoubleTap: null,
                // onDoubleTap: handleLikePost,
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  width: double.infinity,
                  height: 400.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black45,
                        offset: Offset(0, 5),
                        blurRadius: 8.0,
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage(
                        // '${ListPost[index]["image"]}',
                        imgPath,
                      ),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            // IconButton(
                            //   icon: const Icon(Icons.favorite_border_outlined),
                            //   iconSize: 30.0,
                            //   onPressed: () => print('Like Post'),
                            // ),
                            GestureDetector(
                              onTap: null,
                              // onTap: handleLikePost,
                              child: const Icon(
                                // isLiked
                                //     ? Icons.favorite
                                //     :
                                Icons.favorite_border,
                                size: 30.0,
                                color: Colors.pink,
                              ),
                            ),
                            Text(
                              likeNum,
                              style: const TextStyle(
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
                            Text(
                              comNum,
                              style: const TextStyle(
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
              Align(
                alignment: Alignment.centerLeft,
                child: textSection(context),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
