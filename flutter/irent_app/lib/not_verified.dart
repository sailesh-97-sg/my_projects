import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:irent_app/app_icons.dart';
import 'package:irent_app/database.dart';
import 'package:irent_app/switch_nav.dart';
import 'login_register.dart';

class NotVerified extends StatefulWidget {
  const NotVerified({Key? key}) : super(key: key);
  @override
  _NotVerifiedState createState() => _NotVerifiedState();
}

class _NotVerifiedState extends State<NotVerified> {
  final Color white = const Color(0xFFFBFBFF);
  final Color oxford = const Color(0xFF001D4A);
  final Color aliceblue = const Color(0xFF81A4CD);
  final Color marigold = const Color(0xFFECA400);
  String? currentuser = FirebaseAuth.instance.currentUser?.email;
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  @override
  void initState() {
    super.initState();
    try {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    } catch (e) {
      print('error!');
    }
    if (!isEmailVerified) {
      sendVerificationEmail();

      Timer.periodic(Duration(seconds: 3), (_) => checkEmailVerified());
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      print('Something went wrong');
    }
  }

  Widget build(BuildContext context) => isEmailVerified
      ? SwitchNavBar()
      : Scaffold(
          body: Padding(
            padding: EdgeInsets.all(25),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/no.png',
                            height: 210,
                            width: 210,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Email Not Verified",
                            style: TextStyle(
                                color: oxford,
                                fontSize: 25,
                                fontFamily: 'SF_Pro_Rounded',
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1),
                          ),
                          Text(
                            "Please check your email",
                            style: TextStyle(
                                color: oxford,
                                fontSize: 15,
                                fontFamily: 'SF_Pro_Rounded',
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Text(
                              "Didn't receive the verification email?",
                              style: TextStyle(
                                  color: oxford,
                                  fontSize: 15,
                                  fontFamily: 'SF_Pro_Rounded',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1),
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Resend Email',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    canResendEmail
                                        ? sendVerificationEmail
                                        : null;
                                  },
                                style: TextStyle(
                                  color: oxford,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'SF_Pro_Rounded',
                                  letterSpacing: 1,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        )),
                  ]),
            ),
          ),
        );
}
