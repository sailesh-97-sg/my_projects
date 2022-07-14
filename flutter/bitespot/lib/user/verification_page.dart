// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:async';

import 'package:bitespot/user/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;
  final TextEditingController _emailController = TextEditingController();
  String? errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
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

  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState((() => canResendEmail = false));
      await Future.delayed(Duration(seconds: 5));
      setState((() => canResendEmail = true));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? HomePage()
      : SafeArea(
          child: Scaffold(
          backgroundColor: Colors.grey[850],
          appBar: AppBar(
            title: Text('Email Verification'),
            backgroundColor: Colors.black,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 8),
                Lottie.asset('assets/email-verification.json',
                    width: 200, height: 200),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(children: [
                      Text('A verification email will be sent to you shortly.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.barlow(
                              textStyle: TextStyle(
                                  color: Colors.white, fontSize: 22))),
                      SizedBox(height: 20),
                      SizedBox(
                        width: 200,
                        height: 45,
                        child: ElevatedButton(
                            onPressed:
                                canResendEmail ? sendVerificationEmail : null,
                            child: Text('Resend Email',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18)),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.grey[350],
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.black, width: 3),
                                    borderRadius: BorderRadius.circular(20)))),
                      ),
                    ])),
              ],
            ),
          ),
        ));
  // BuildContext

  // Future here
} // State

