// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'login.dart';
import 'signup_page.dart';
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:irent_app/admin/admin_login.dart';

class LoginRegisterScreen extends StatelessWidget {
  final Color white = const Color(0xFFFBFBFF);
  final Color oxford = const Color(0xFF001D4A);
  final Color aliceblue = const Color(0xFF81A4CD);
  final Color marigold = const Color(0xFFECA400);
  final Color transparent = const Color(0x4DE3E3E3);
  const LoginRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: aliceblue,
      body: Stack(
        children: [
          Container(
              width: screenwidth,
              height: screenheight,
              foregroundDecoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('images/cross_bg.png'),
                fit: BoxFit.fill,
              ))),
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: white,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Image.asset(
                    'images/irent-logo.png',
                    width: screenwidth * 0.12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(height: screenheight * 0.35),
              Image.asset(
                'images/hand.png',
                width: screenwidth,
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(height: screenheight * 0.25),
              Center(
                child: Image.asset(
                  'images/board-game.png',
                  width: screenwidth * 0.65,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: screenwidth * 0.12),
                  width: screenwidth,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        SizedBox(
                          height: screenheight * 0.15,
                        ),
                        const Text(
                          'iRent',
                          style: TextStyle(
                              color: Color(0xFFFBFBFF),
                              fontSize: 45,
                              fontFamily: 'SF_Pro_Rounded',
                              fontWeight: FontWeight.w500,
                              letterSpacing: 2),
                        ),
                        const Text(
                          'Borrowing Made Easy.',
                          style: TextStyle(
                              color: Color(0xFFFBFBFF),
                              fontSize: 18,
                              fontFamily: 'SF_Pro_Rounded',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 2),
                        ),
                        SizedBox(
                          height: screenheight * 0.45,
                        ),
                        ButtonTheme(
                          minWidth: 300,
                          height: 45,
                          child: BackdropFilter(
                            filter: ImageFilter.blur(),
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignupPage()));
                              },
                              color: transparent,
                              child: Text(
                                'Sign Up',
                                style: TextStyle(color: white),
                              ),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: white),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ButtonTheme(
                          minWidth: 300,
                          height: 45,
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ));
                            },
                            color: white,
                            child: Text(
                              'Login',
                              style: TextStyle(color: oxford),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 100, top: 20),
                            child: RichText(
                              text: TextSpan(
                                text: 'Login as ',
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Admin',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AdminLoginPage()));
                                      },
                                  )
                                ],
                                style: TextStyle(
                                  color: white,
                                  fontFamily: 'SF_Pro_Rounded',
                                  fontSize: 17,
                                ),
                              ),
                            ))
                      ]),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
