// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, must_call_super, unused_local_variable, avoid_single_cascade_in_expression_statements, unused_label

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

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
  late Animation<double> _animation;
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1450));
    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
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
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('AlbumTracker',
                                  style: TextStyle(fontSize: 40)),
                              Text(
                                  'An application for users to see a list of albums by\nartists and track the number of favourited albums',
                                  style: TextStyle(fontSize: 20))
                            ]),
                        Stack(
                          children: [
                            Container(),
                            Positioned(
                                left: 0.0,
                                top: 0.0,
                                child: Image.asset('images/app_mainpage.png'))
                          ],
                        )
                      ],
                    ))
              ],
            ),
          )),
    );
  }

  introductionName() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Sailesh Gopalakrishnan',
              style: GoogleFonts.dancingScript(
                  fontSize: 70,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          Text('UI/UX Designer and Frontend Developer',
              style: GoogleFonts.arsenal(
                  fontStyle: FontStyle.italic,
                  fontSize: 30,
                  color: Colors.white))
        ],
      ),
    );
  }
}
