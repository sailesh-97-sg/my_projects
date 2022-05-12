// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:irent_app/switch_nav.dart';
import 'homepage.dart';
import 'constants.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Color white = const Color(0xFFFBFBFF);
  final Color oxford = const Color(0xFF001D4A);
  final Color aliceblue = const Color(0xFF81A4CD);
  final Color iceberg = const Color(0xFFDBE4EE);
  final Color marigold = const Color(0xFFECA400);
  final Color transparent = const Color(0x4DE3E3E3);

  bool? _success;
  String? _userEmail;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: white,
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  color: aliceblue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  )),
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      'images/cross-bg-cropped-2.png',
                    ),
                  ),
                  Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      centerTitle: true,
                      title: Text(
                        'About Us',
                        style: TextStyle(
                            color: oxford,
                            fontFamily: 'SF_Pro_Rounded',
                            fontSize: 25,
                            fontWeight: FontWeight.w500),
                      ),
                      elevation: 0,
                      leading: Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.close,
                              size: 32,
                              color: oxford,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(25),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                      decoration: BoxDecoration(
                          color: iceberg,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Text(
                            "What is iRent?",
                            style: TextStyle(
                                fontFamily: 'SF_Pro_Rounded',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: oxford,
                                letterSpacing: 0.5),
                          ),
                          SizedBox(height: 15),
                          Text(
                            whatIsiRent,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'SF_Pro_Rounded',
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: oxford,
                                letterSpacing: 0.5),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Image.asset(
                        'images/coins.png',
                        //width: double.infinity,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                      decoration: BoxDecoration(
                          color: iceberg,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Text(
                            "Policies",
                            style: TextStyle(
                                fontFamily: 'SF_Pro_Rounded',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: oxford,
                                letterSpacing: 0.5),
                          ),
                          SizedBox(height: 15),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Image.asset('images/camera.png')),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    _policyEntry(policy: policy_1),
                                    _policyEntry(policy: policy_2),
                                    _policyEntry(policy: policy_3),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _policyEntry({required String policy}) {
    return ListTile(
      leading: new MyBullet(),
      minLeadingWidth: 0,
      title: Text(
        policy,
        style: TextStyle(
            fontFamily: 'SF_Pro_Rounded',
            fontSize: 14,
            fontWeight: FontWeight.w300,
            color: oxford,
            letterSpacing: 0.5),
      ),
    );
  }
}

class MyBullet extends StatelessWidget {
  final Color oxford = const Color(0xFF001D4A);

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 5.0,
      width: 5.0,
      decoration: new BoxDecoration(
        color: oxford,
        shape: BoxShape.circle,
      ),
    );
  }
}
