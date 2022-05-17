// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, must_call_super, unused_local_variable, avoid_single_cascade_in_expression_statements, unused_label
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';

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
    if (kIsWeb) {
      return Scaffold(
        backgroundColor: Color.fromARGB(255, 36, 36, 36),
        appBar: AppBar(
            title: Text('Sailesh Gopalakrishnan'),
            backgroundColor: Colors.black),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  introductionName(),
                  introductionDetailed(),
                  albumApp(),
                  iRentApp(),
                  familiarTechnologies(),
                ],
              ),
            )),
      );
    } else {
      throw '';
    }
  }

  introductionDetailed() {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenwidth,
      height: screenheight,
      decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.white),
          ),
          gradient: LinearGradient(
              stops: [0.9, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color.fromARGB(255, 220, 220, 220), Colors.white])),
      child: Column(
        children: [
          Row(
            children: [Container(color: Colors.blue)],
          )
        ],
      ),
    );
  }

  albumApp() {
    return Container(
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.white)),
            gradient: LinearGradient(
                stops: [0.9, 1.0],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.black])),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
        decoration: BoxDecoration(
            gradient: LinearGradient(
                stops: [0.9, 1.0],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Color.fromARGB(255, 0, 5, 74)])),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    return Container(
        padding: EdgeInsets.only(left: 30, right: 30),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color.fromARGB(255, 0, 5, 74),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Familiar Technologies',
                style: GoogleFonts.arsenal(
                    shadows: [
                      Shadow(
                          blurRadius: 7.0,
                          color: Colors.white,
                          offset: Offset(0, 0))
                    ],
                    fontStyle: FontStyle.italic,
                    fontSize: 30,
                    color: Colors.white)),
            SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Container(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: screenheight / 3,
                    maxWidth: screenwidth / 5,
                  ),
                  child: Column(
                    children: [
                      Image.asset('images/firebase.png',
                          height: 100, width: 100),
                      SizedBox(height: 10),
                      AutoSizeText(
                          textAlign: TextAlign.center,
                          'Used Firebase Auth and Firebase Firestore for developing iRent',
                          style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
              ),
              Container(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: screenheight / 3,
                    maxWidth: screenwidth / 5,
                  ),
                  child: Column(
                    children: [
                      Image.asset('images/flutter.png',
                          height: 100, width: 100),
                      SizedBox(height: 10),
                      AutoSizeText(
                          textAlign: TextAlign.center,
                          'Used Flutter for developing mobile applications and this portfolio site',
                          style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
              ),
              Container(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: screenheight / 3,
                    maxWidth: screenwidth / 5,
                  ),
                  child: Column(
                    children: [
                      Image.asset('images/wordpress.png',
                          height: 100, width: 100),
                      SizedBox(height: 10),
                      AutoSizeText(
                          textAlign: TextAlign.center,
                          'Used WordPress to design the previous portfolio site',
                          style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Container(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: screenheight / 3,
                    maxWidth: screenwidth / 5,
                  ),
                  child: Column(
                    children: [
                      Image.asset('images/kubernetes.png',
                          height: 100, width: 100),
                      SizedBox(height: 10),
                      AutoSizeText(
                          textAlign: TextAlign.center,
                          'Used Kubernetes for managing Docker containers in on-premise servers which have been pushed using GitLab CI/CD',
                          style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
              ),
              Container(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: screenheight / 3,
                    maxWidth: screenwidth / 5,
                  ),
                  child: Column(
                    children: [
                      Image.asset('images/python.png', height: 100, width: 100),
                      SizedBox(height: 10),
                      AutoSizeText(
                          textAlign: TextAlign.center,
                          'Used Python for implementing Machine Learning and Data Analysis projects for University ',
                          style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
              ),
              Container(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: screenheight / 3,
                    maxWidth: screenwidth / 5,
                  ),
                  child: Column(
                    children: [
                      Image.asset('images/chrome.png', height: 100, width: 100),
                      SizedBox(height: 10),
                      AutoSizeText(
                          textAlign: TextAlign.center,
                          'Used Javascript to develop Chrome Extensions as part of a project related to Sustainable Web Development',
                          style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
              ),
            ])
          ],
        ));
  }
}
