// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, must_call_super, unused_local_variable, avoid_single_cascade_in_expression_statements, unused_label, @dart=2.9
import 'package:delayed_display/delayed_display.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'dart:io' show Platform;
import 'package:timeline_tile/timeline_tile.dart';
import 'package:universal_html/html.dart' hide Text;
import 'package:url_launcher/url_launcher.dart';

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
                  awsCertification(),
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

  downloadFile(url) {
    AnchorElement anchorElement = new AnchorElement(href: url);
    anchorElement.download = "Resume";
    anchorElement.click();
  }

  introductionDetailed() {
    int currentStep = 0;
    var screenheight = MediaQuery.of(context).size.height * 1.5;
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
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('About Me',
            style: TextStyle(
                fontSize: 60,
                letterSpacing: 4,
                color: Colors.black.withOpacity(0.8))),
        Container(
          height: 40,
          margin: EdgeInsets.only(top: 10),
          child: ElevatedButton(
              // ignore: sort_child_properties_last
              child: Text(
                'View Resume',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => downloadFile(
                  'https://onedrive.live.com/embed?cid=A9552CE7407F7ED6&resid=A9552CE7407F7ED6%2114781&authkey=AKeW67kVQETEJ80&em=2'),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  primary: Colors.black)),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: screenwidth / 1.5,
          child: Text(
            'I am a student studying in Electrical & Electronic Engineering in Nanyang Technological University. Over my years in university, I\'ve gained an interest in Software Development, and have started working towards a full time development position. My hobbies include reading novels, gaming and playing around with smart home technology.',
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 60,
        ),
        Container(
            height: 150,
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: TimelineTile(
                      axis: TimelineAxis.horizontal,
                      afterLineStyle: LineStyle(color: Colors.orange),
                      alignment: TimelineAlign.center,
                      indicatorStyle:
                          IndicatorStyle(color: Colors.black, width: 30),
                      endChild: Container(
                        margin: EdgeInsets.only(top: 10),
                        alignment: Alignment.center,
                        constraints: const BoxConstraints(
                          minWidth: 200,
                        ),
                        child: Text(
                          'Bartley Secondary School\n(Secondary Education)',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      //    AnimatedTextKit(
                      //   totalRepeatCount: 4,
                      //   animatedTexts: [
                      //     TypewriterAnimatedText('AlbumHub',
                      //         textStyle: TextStyle(fontSize: 30))
                      //   ],
                      // ),
                      isFirst: true,
                      startChild: DelayedDisplay(
                        delay: Duration(seconds: 2),
                        child: AnimatedTextKit(
                          totalRepeatCount: 1,
                          animatedTexts: [
                            TypewriterAnimatedText('2011',
                                textStyle:
                                    TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text('Bartley Secondary School',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                content: Text(
                                    'Studied for four years in Bartley Secondary School under the Express stream, and was an Staff Sergeant in the National Cadet Corps (NCC). I was involved in organising camps as well as organising training sessions for the juniors, and also participated in the Singapore Youth Festival parade, and was one of the two people selected to be involved in an Advanced Drills Course (ADC)'),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("OK")),
                                ],
                              ));
                    },
                  ),
                  GestureDetector(
                    child: TimelineTile(
                      isFirst: false,
                      isLast: false,
                      beforeLineStyle: LineStyle(color: Colors.red),
                      axis: TimelineAxis.horizontal,
                      indicatorStyle:
                          IndicatorStyle(color: Colors.black, width: 40),
                      alignment: TimelineAlign.center,
                      endChild: Container(
                        margin: EdgeInsets.only(top: 10),
                        alignment: Alignment.center,
                        constraints: const BoxConstraints(
                          minWidth: 200,
                        ),
                        child: Text(
                          'Ngee Ann Polytechnic\n(Aerospace Electronics)',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      startChild: DelayedDisplay(
                        delay: Duration(seconds: 3),
                        child: AnimatedTextKit(
                          totalRepeatCount: 1,
                          animatedTexts: [
                            TypewriterAnimatedText('2014',
                                textStyle:
                                    TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                    ),
                    onTap: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text('Ngee Ann Polytechnic',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              content: Text(
                                  'Studied for 3 years in Polytechnic as a student taking Aerospace Electronics with a Minor in Business Management. Was part of the sub-committee of the Computer Club, and was responsible for organising events for the club members.'),
                              actions: [
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () => Navigator.pop(context),
                                )
                              ],
                            )),
                  ),
                  GestureDetector(
                    child: TimelineTile(
                      isFirst: false,
                      isLast: false,
                      axis: TimelineAxis.horizontal,
                      indicatorStyle:
                          IndicatorStyle(color: Colors.black, width: 30),
                      beforeLineStyle: LineStyle(color: Colors.green),
                      alignment: TimelineAlign.center,
                      endChild: Container(
                        margin: EdgeInsets.only(top: 10),
                        alignment: Alignment.center,
                        constraints: const BoxConstraints(
                          minWidth: 200,
                        ),
                        child: Text(
                          'Singapore Armed Forces\n(Singapore Guards)',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      startChild: DelayedDisplay(
                        delay: Duration(seconds: 4),
                        child: AnimatedTextKit(
                          totalRepeatCount: 1,
                          animatedTexts: [
                            TypewriterAnimatedText('2017',
                                textStyle:
                                    TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                    ),
                    onTap: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text('Singapore Armed Forces',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              content: Text(
                                  'Served 2 years in the Singapore Guards as part of National Service. Went through the Guards Vocational Training and earned the Guards tab, and also took a Signaller Course to learn more about relaying communications in the battlefield. After graduation from the Signaller Course, served as a Guards Signaller for the remainder of the National Service period.'),
                              actions: [
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () => Navigator.pop(context),
                                )
                              ],
                            )),
                  ),
                  GestureDetector(
                      child: TimelineTile(
                        isFirst: false,
                        isLast: false,
                        indicatorStyle:
                            IndicatorStyle(color: Colors.black, width: 30),
                        axis: TimelineAxis.horizontal,
                        alignment: TimelineAlign.center,
                        beforeLineStyle: LineStyle(color: Colors.blue),
                        endChild: Container(
                          margin: EdgeInsets.only(top: 10),
                          alignment: Alignment.center,
                          constraints: const BoxConstraints(
                            minWidth: 200,
                          ),
                          child: Text(
                            'Nanyang Technological University\n(Electrical & Electronic Engineering)',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        startChild: DelayedDisplay(
                          delay: Duration(seconds: 5),
                          child: AnimatedTextKit(
                            totalRepeatCount: 1,
                            animatedTexts: [
                              TypewriterAnimatedText('2020',
                                  textStyle:
                                      TextStyle(fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      ),
                      onTap: () => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text('Nanyang Technological University',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                content: Text(
                                    'Studied Electrical & Electronic Engineering in NTU. Took a course in Data Science and Artificial Intelligence to carry out projects which used Classification models such as XGBoost and Random Forest, as well as Linear Regression projects for business analysis. Also participated in a project which involved creating a Flutter based application, and took modules related to Computer Engineering, which I specialized in during my final year.'),
                                actions: [
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () => Navigator.pop(context),
                                  )
                                ],
                              ))),
                  GestureDetector(
                      child: TimelineTile(
                        isFirst: false,
                        isLast: true,
                        indicatorStyle:
                            IndicatorStyle(color: Colors.black, width: 30),
                        axis: TimelineAxis.horizontal,
                        alignment: TimelineAlign.center,
                        beforeLineStyle: LineStyle(color: Colors.black),
                        endChild: Container(
                          margin: EdgeInsets.only(top: 10),
                          alignment: Alignment.center,
                          constraints: const BoxConstraints(
                            minWidth: 200,
                          ),
                          child: Text(
                            'Professional Internship\n(Thales)',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        startChild: DelayedDisplay(
                          delay: Duration(seconds: 6),
                          child: AnimatedTextKit(
                            totalRepeatCount: 1,
                            animatedTexts: [
                              TypewriterAnimatedText('2021',
                                  textStyle:
                                      TextStyle(fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      ),
                      onTap: () => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text('Thales Internship',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                content: Text(
                                    'Worked as an AI Automation Engineer, responsible for automating CI/CD Pipelines using GitLab CI/CD to push Machine Learning models to containers in on-premise servers, managed by Kubernetes. Also managed the configuration of Kubernetes Clusters by making use of YAML configuration files. Researched other potential alternatives for improving the infastructure, such as Kubeflow or GPU Acceleration and carried out the implementation.'),
                                actions: [
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () => Navigator.pop(context),
                                  )
                                ],
                              ))),
                ],
              ),
            ))
      ]),
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
      //               left: MediaQuery.of(context).size.width / 3 - 30,
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
                colors: [Colors.black, Colors.white])),
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
          Text('Solutions Architect and Fullstack Developer',
              textAlign: TextAlign.center,
              style: GoogleFonts.arsenal(
                  fontStyle: FontStyle.italic,
                  fontSize: 30,
                  color: Colors.white))
        ],
      ),
    );
  }

  awsCertification() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              stops: [0.9, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Color.fromARGB(255, 0, 5, 74)])),
      child: Container(
        margin: EdgeInsets.all(20),
        child: Center(
            child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Image.asset(
                  'images/awssa.png',
                  height: 200,
                  width: 200,
                )),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'AWS Certified Solutions Architect (Associate)',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Passed my AWS Solutions Architect Associate on August 2022. Have experience deploying applications on AWS Amplify, as well as hosting static websites manually using S3 and Cloudfront. Have knowledge on serverless architectures as well as cost optimizing deployments on AWS, as well as knowledge of more existing tools in AWS through studying for the AWS SA exam.',
                    textAlign: TextAlign.start,
                  )
                ],
              ),
            )
          ],
        )),
      ),
    );
  }

  familiarTechnologies() {
    var myGroup = AutoSizeGroup();
    var screenheight = MediaQuery.of(context).size.height * 1.5;
    var screenwidth = MediaQuery.of(context).size.width;
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                stops: [0.9, 1.0],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 0, 5, 74),
                  Color.fromARGB(238, 239, 235, 235)
                ])),
        padding: EdgeInsets.only(left: 30, right: 30),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 1.5,
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
                    maxHeight: screenheight / 5,
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
                          'Firebase',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              ),
              Container(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: screenheight / 5,
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
                          'Flutter',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              ),
              Container(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: screenheight / 5,
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
                          'WordPress',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Container(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: screenheight / 5,
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
                          'Kubernetes',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              ),
              Container(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: screenheight / 5,
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
                          'Python',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              ),
              Container(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: screenheight / 5,
                    maxWidth: screenwidth / 4,
                  ),
                  child: Column(
                    children: [
                      Image.asset('images/chrome.png', height: 100, width: 100),
                      SizedBox(height: 10),
                      AutoSizeText(
                          group: myGroup,
                          textAlign: TextAlign.center,
                          'Chrome Extensions',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Container(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: screenheight / 5,
                    maxWidth: screenwidth / 4,
                  ),
                  child: Column(
                    children: [
                      Image.asset('images/html5.png', height: 100, width: 100),
                      SizedBox(height: 10),
                      AutoSizeText(
                          group: myGroup,
                          minFontSize: 10,
                          textAlign: TextAlign.center,
                          'HTML5',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              ),
              Container(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: screenheight / 5,
                    maxWidth: screenwidth / 4,
                  ),
                  child: Column(
                    children: [
                      Image.asset('images/css3.png', height: 100, width: 100),
                      SizedBox(height: 10),
                      AutoSizeText(
                          group: myGroup,
                          minFontSize: 10,
                          textAlign: TextAlign.center,
                          'CSS3',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              ),
              Container(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: screenheight / 5,
                    maxWidth: screenwidth / 4,
                  ),
                  child: Column(
                    children: [
                      Image.asset('images/awslogo.png',
                          height: 100, width: 100),
                      SizedBox(height: 10),
                      AutoSizeText(
                          group: myGroup,
                          minFontSize: 10,
                          textAlign: TextAlign.center,
                          'AWS',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              ),
            ]),
          ],
        ));
  }

  linksSection() {
    return Container(
        color: Color.fromARGB(238, 239, 235, 235),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 4,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
            flex: 2,
            child: GestureDetector(
              child: Container(
                  padding: EdgeInsets.all(30),
                  child: Image.asset('images/github.png')),
              onTap: () async {
                final url = 'https://github.com/sailesh-97-sg/my_projects';
                if (await canLaunch(url)) {
                  await launch(url,
                      forceSafariVC: true,
                      forceWebView: true,
                      enableJavaScript: true);
                }
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: GestureDetector(
              child: Container(
                  padding: EdgeInsets.all(30),
                  child: Image.asset('images/mail.png')),
              onTap: () async {
                final toEmail = 'contact@sailsg.com';
                final subject = '';
                final message = '';
                final url =
                    "mailto:$toEmail?subject=${subject}&body=${Uri.encodeFull(message)}";
                if (await canLaunch(url)) {
                  await launch(url);
                }
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
                padding: EdgeInsets.all(30),
                child: Image.asset('images/linkedin.png')),
          )
        ]));
  }
}
