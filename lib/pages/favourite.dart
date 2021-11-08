// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

class Favorite extends StatelessWidget {
  final List favoritePost;

  const Favorite({Key? key, required this.favoritePost}) : super(key: key);
//favoritePost[index]
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 8.0,
        toolbarHeight: 60,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 55),
              child: const Text(
                'Favourite Post',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg.jpg"), fit: BoxFit.cover),
        ),
        child: ListView.builder(
          itemCount: favoritePost.length,
          itemBuilder: (BuildContext context, int index) {
            //bool isSaved = savedPost.contains(favoritePost[index]);
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              elevation: 9, // Change this
              shadowColor: Colors.black, // Change this
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(left: 10, right: 20),
                          width: 60.0,
                          height: 60.0,
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
                                width: 60.0,
                                height: 60.0,
                                image: NetworkImage(
                                    'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                favoritePost[index]["author"],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Posted on ${favoritePost[index]["date"].toString().characters.take(10)}',
                                style: const TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                                iconSize: 30,
                                onPressed: () {
                                  //ListPost.removeAt(index);
                                  setState(() {
                                    favoritePost.indexOf(favoritePost[index]);
                                    favoritePost.removeAt(index);
                                  });
                                },
                                icon: const Icon(Icons.delete_outline_rounded)),
                            IconButton(
                                //isSaved ? Icons.favorite : Icons.favorite_border,
                                //color: favoritePost[index] ? Colors.red : Colors.black,
                                color: Colors.pink,
                                iconSize: 30,
                                onPressed: () {
                                  setState(() {
                                    if (favoritePost[index]) {
                                      favoritePost.remove(favoritePost[index]);
                                    } else {
                                      favoritePost.add(favoritePost[index]);
                                    }
                                  });
                                },
                                icon: const Icon(Icons.favorite)),
                          ],
                        ),
                        // ignore: avoid_unnecessary_containers
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
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
                          image: NetworkImage(
                            favoritePost[index]["image"],
                          ),
                        ),
                      ),
                    ),
                    Container(
                        width: 330,
                        child: Text(
                          "${favoritePost[index]["description"]}",
                          style: const TextStyle(fontSize: 17),
                        ))
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void setState(Null Function() param0) {}
}
