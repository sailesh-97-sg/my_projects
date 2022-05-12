// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'gallerypage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Challenge',
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey[850],
          body: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 300,
                      height: 300,
                      child: Lottie.asset('assets/musicanimation.json')),
                  Text('Ed Sheeran',
                      style: GoogleFonts.arsenal(
                          textStyle:
                              TextStyle(fontSize: 30, color: Colors.white))),
                  SizedBox(height: 20),
                  SizedBox(
                      width: 200,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GalleryPage()));
                          },
                          child: Text('Explore',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18)),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.grey[350],
                              shape: RoundedRectangleBorder(
                                  side:
                                      BorderSide(color: Colors.black, width: 3),
                                  borderRadius: BorderRadius.circular(20)))))
                ],
              ))),
    );
  }
}
