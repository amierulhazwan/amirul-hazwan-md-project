import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'About BeSquareGram',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.cancel,
                size: 30.0,
              )),
        ],
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 20.0),
              margin: const EdgeInsets.all(30.0),
              width: double.infinity,
              // height: 580.0,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    offset: Offset(0, 2),
                    blurRadius: 6.0,
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    height: 200,
                    color: Colors.white,
                    child: Image.asset(
                      'assets/icon.png',
                      width: 300,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    width: 250,
                    child: const Text(
                      'Deriv’s 6-month graduate programme gives you a holistic learning experience with real-world scenarios, backed by a well-structured curriculum. Learn essential skills from innovative IT teams in an established, global FinTech company. If you’re exceptional at embracing BeSquare challenges and our company values, you’ll get an immediate job offer from Deriv at the end of the programme.',
                      style: TextStyle(fontSize: 15),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
// -----------------------------------------------------------------------------------------------------------
    );
  }
}
