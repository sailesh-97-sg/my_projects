// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, must_call_super, unused_local_variable, avoid_single_cascade_in_expression_statements, unused_label
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'dart:io' show Platform;

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
                  linksSection()
                ],
              ),
            )),
      );
    } else {
      return Scaffold(
        backgroundColor: Color.fromARGB(255, 36, 36, 36),
        appBar: AppBar(
          title: Text('Sailesh Gopalakrishnan'),
          backgroundColor: Colors.black,
        ),
        body: Container(width: MediaQuery.of(context).size.width),
      );
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
      child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Text('Hawker Pacific Asia'),
              Text('Electrical & Electronic Engineering'),
              Text('Thales')
            ]),
            Text('About Me',
                style: TextStyle(
                    fontSize: 60,
                    letterSpacing: 4,
                    color: Colors.black.withOpacity(0.2))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text('Project Flux Internship'),
                              content: Text(
                                  'I worked as a Chrome Extension Developer in Project Flux, creating extensions that contributed towards Sustainable Web Development. This involved coming up with extensions that reduced carbon emissions and amount of data transferred so that less energy is used.'),
                              actions: [
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () => Navigator.pop(context),
                                )
                              ],
                            )),
                    child: Text('Project Flux')),
                GestureDetector(
                    onTap: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text('Computer Engineering'),
                              content: Text(
                                  'I am specializing in Computer Engineering in University, having taken Data Structures and Algorithms, Computer Communications, Software Engineering and several other relevant modules.'),
                              actions: [
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () => Navigator.pop(context),
                                )
                              ],
                            )),
                    child: Text('Computer Engineering')),
                Text('Hobbies')
              ],
            )
            //             ),],
          ])),
      // child: Column(
      //   children: [
      //     Container(
      //         padding: EdgeInsets.all(50),
      //         height: screenheight - 1,
      //         child: Stack(
      //           children: [
      //             Positioned(
      //               top: MediaQuery.of(context).size.height / 3.2,
      //               left: MediaQuery.of(context).size.width / 3.2,
      //               child: Text('About Me',
      //                   style: TextStyle(
      //                       fontSize: 80,
      //                       letterSpacing: 4,
      //                       color: Colors.black.withOpacity(0.2))),
      //             ),
      //             Positioned(
      //               top: MediaQuery.of(context).size.height / 2.9,
      //               left: MediaQuery.of(context).size.width / 3 - 40,
      //               child: Text(
      //                 'I am a student studying Electrical & Electronic\nEngineering in Nanyang Technological University',
      //                 style: TextStyle(fontSize: 20),
      //               ),
      //             ),
      //             Positioned(
      //               top: MediaQuery.of(context).size.height / 2.1,
      //               left: MediaQuery.of(context).size.width / 2.65,
      //               child: SizedBox(
      //                 height: MediaQuery.of(context).size.height / 20,
      //                 width: MediaQuery.of(context).size.width / 7,
      //                 child: ElevatedButton(
      //                   style: ElevatedButton.styleFrom(
      //                       elevation: 20,
      //                       primary: Colors.white,
      //                       shape: RoundedRectangleBorder(
      //                           borderRadius: BorderRadius.circular(15))),
      //                   child: Text('Download Resume',
      //                       style: TextStyle(color: Colors.black)),
      //                   onPressed: () {},
      //                 ),
      //               ),
      //             )
      //           ],
      //         )),
      //   ],
      // ),
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
                margin: EdgeInsets.only(left: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedTextKit(
                        totalRepeatCount: 4,
                        animatedTexts: [
                          TypewriterAnimatedText('AlbumHub',
                              textStyle: TextStyle(fontSize: 30))
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
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width * 0.15,
                        height: MediaQuery.of(context).size.height * 0.06,
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
                          top: MediaQuery.of(context).size.height / 40,
                          left: 200,
                          height: MediaQuery.of(context).size.height * 0.85,
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Image.asset('images/app_sidepage.png'),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height / 40,
                          left: 0,
                          height: MediaQuery.of(context).size.height * 0.85,
                          width: MediaQuery.of(context).size.width * 0.45,
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
                                  TextStyle(fontSize: 30, color: Colors.white))
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
                  fontSize: 55,
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
    var myGroup = AutoSizeGroup();
    var screenheight = MediaQuery.of(context).size.height + 50;
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
                    maxWidth: screenwidth / 4,
                  ),
                  child: Column(
                    children: [
                      Image.asset('images/firebase.png',
                          height: 100, width: 100),
                      SizedBox(height: 10),
                      AutoSizeText(
                          group: myGroup,
                          minFontSize: 10,
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
                    maxWidth: screenwidth / 4,
                  ),
                  child: Column(
                    children: [
                      Image.asset('images/flutter.png',
                          height: 100, width: 100),
                      SizedBox(height: 10),
                      AutoSizeText(
                          group: myGroup,
                          minFontSize: 10,
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
                    maxWidth: screenwidth / 4,
                  ),
                  child: Column(
                    children: [
                      Image.asset('images/wordpress.png',
                          height: 100, width: 100),
                      SizedBox(height: 10),
                      AutoSizeText(
                          group: myGroup,
                          minFontSize: 10,
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
                    maxWidth: screenwidth / 4,
                  ),
                  child: Column(
                    children: [
                      Image.asset('images/kubernetes.png',
                          height: 100, width: 100),
                      SizedBox(height: 10),
                      AutoSizeText(
                          group: myGroup,
                          minFontSize: 10,
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
                    maxWidth: screenwidth / 4,
                  ),
                  child: Column(
                    children: [
                      Image.asset('images/python.png', height: 100, width: 100),
                      SizedBox(height: 10),
                      AutoSizeText(
                          group: myGroup,
                          textAlign: TextAlign.center,
                          minFontSize: 10,
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
                    maxWidth: screenwidth / 4,
                  ),
                  child: Column(
                    children: [
                      Image.asset('images/chrome.png', height: 100, width: 100),
                      SizedBox(height: 10),
                      AutoSizeText(
                          group: myGroup,
                          textAlign: TextAlign.center,
                          'Used Javascript to develop Chrome Extensions as part of a project related to Sustainable Web Development',
                          style: TextStyle(color: Colors.white, fontSize: 8))
                    ],
                  ),
                ),
              ),
            ])
          ],
        ));
  }

  linksSection() {
    return Container(
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.white)),
            gradient: LinearGradient(
                stops: [0.9, 1.0],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.black])),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 4,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [Image.asset('images/github.png')]));
  }
}
