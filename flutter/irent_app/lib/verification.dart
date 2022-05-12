import 'dart:async';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:irent_app/login.dart';
import 'package:irent_app/switch_nav.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key}) : super(key: key);
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
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
          body: Column(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 50, bottom: 100),
                  width: MediaQuery.of(context).size.width,
                  color: Color(0xFF81A4CD),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        const Text(
                          'Verification',
                          style: TextStyle(
                              color: Color(0xFFFBFBFF),
                              fontSize: 45,
                              fontFamily: 'SF_Pro_Rounded',
                              fontWeight: FontWeight.w500),
                        ),
                        const Text(
                          'Please check your email for verification',
                          style: TextStyle(
                              color: Color(0xFFFBFBFF),
                              fontSize: 18,
                              fontFamily: 'SF_Pro_Rounded',
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 215,
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
                            color: Color(0xFFFBFBFF),
                            child: Text(
                              'Login Again',
                              style: TextStyle(color: Color(0xFF001D4A)),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                        ButtonTheme(
                          minWidth: 300,
                          height: 45,
                          child: RaisedButton(
                            onPressed:
                                canResendEmail ? sendVerificationEmail : null,
                            color: Colors.orange,
                            child: Text(
                              'Resend Email',
                              style: TextStyle(color: Color(0xFF001D4A)),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ]),
                ),
              )
            ],
          ),
        );
}
