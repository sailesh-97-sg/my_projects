// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, must_call_super, unused_local_variable, avoid_single_cascade_in_expression_statements, unused_label

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Portfolio Page', home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
          title: Text('Sailesh Gopalakrishnan'), backgroundColor: Colors.black),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                introductionName(),
                albumApp(),
                iRentApp(),
                familiarTechnologies(),
              ],
            ),
          )),
    );
  }

  albumApp() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                margin: EdgeInsets.only(left: 50),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedTextKit(
                        totalRepeatCount: 4,
                        animatedTexts: [
                          TypewriterAnimatedText('AlbumTracker',
                              textStyle: TextStyle(fontSize: 40))
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          child: Text('Front-end Development • UI/UX Design',
                              style: TextStyle(
                                  fontSize: 17, fontStyle: FontStyle.italic))),
                      AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts: [
                          TypewriterAnimatedText(
                              'An application for users to see a list of albums by\nartists and track the number of favourited albums.',
                              textStyle: TextStyle(fontSize: 20))
                        ],
                      ),
                      SizedBox(height: 80),
                      Text('Platforms Supported: ',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold)),
                      Image.asset(
                        'images/android.png',
                        width: MediaQuery.of(context).size.width * 0.10,
                        height: MediaQuery.of(context).size.height * 0.10,
                      )
                    ]),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height,
                    child: Stack(
                      children: [
                        Container(),
                        Positioned(
                          top: 20,
                          left: 200,
                          height: 600,
                          width: 500,
                          child: Image.asset('images/app_sidepage.png'),
                        ),
                        Positioned(
                          top: 100,
                          left: 0,
                          height: 600,
                          width: 500,
                          child: Image.asset('images/app_mainpage.png'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  iRentApp() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedTextKit(
                        repeatForever: true,
                        pause: Duration(milliseconds: 2000),
                        animatedTexts: [
                          TypewriterAnimatedText('iRent',
                              textStyle:
                                  TextStyle(fontSize: 40, color: Colors.white))
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          child: Text('Fullstack Development • UI/UX Design',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white))),
                      AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts: [
                          TypewriterAnimatedText(
                              'An application for university students to rent out their\nitems to other students for a small fee.',
                              textStyle:
                                  TextStyle(fontSize: 20, color: Colors.white))
                        ],
                      ),
                      SizedBox(height: 80),
                      Text('Platforms Supported: ',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      SizedBox(height: 20),
                      Image.asset('images/iosandroid.png',
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.height * 0.06)
                    ]),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    child: Stack(
                      children: [
                        Container(),
                        Positioned(
                          top: 20,
                          left: 200,
                          height: MediaQuery.of(context).size.height * 0.85,
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Image.asset('images/irent_signuppage.png'),
                        ),
                        Positioned(
                          top: 20,
                          left: 28,
                          height: MediaQuery.of(context).size.height * 0.85,
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Image.asset('images/irent_mainpage.png'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  introductionName() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Sailesh Gopalakrishnan',
              textAlign: TextAlign.center,
              style: GoogleFonts.dancingScript(
                  fontSize: 65,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          SizedBox(height: 20),
          Text('UI/UX Designer and Frontend Developer',
              textAlign: TextAlign.center,
              style: GoogleFonts.arsenal(
                  fontStyle: FontStyle.italic,
                  fontSize: 30,
                  color: Colors.white))
        ],
      ),
    );
  }

  familiarTechnologies() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color.fromARGB(255, 0, 5, 74),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Familiar Technologies',
                style: GoogleFonts.arsenal(
                    fontStyle: FontStyle.italic,
                    fontSize: 30,
                    color: Colors.white)),
            Row(children: [
              Image.asset('images/firebase.png'),
              Text('!!',
                  style: GoogleFonts.arsenal(
                      fontStyle: FontStyle.italic,
                      fontSize: 30,
                      color: Colors.white)),
              Text('!!',
                  style: GoogleFonts.arsenal(
                      fontStyle: FontStyle.italic,
                      fontSize: 30,
                      color: Colors.white))
            ])
          ],
        ));
  }
}
