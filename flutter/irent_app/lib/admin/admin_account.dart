// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:irent_app/app_icons.dart';
import 'package:irent_app/database.dart';
import 'package:irent_app/change_passcode.dart';
import '../login_register.dart';
import 'admin_user_feedback.dart';
import 'admin_alert.dart';

class AdminAccountScreen extends StatelessWidget {
  final Color white = const Color(0xFFFBFBFF);
  final Color oxford = const Color(0xFF001D4A);
  final Color aliceblue = const Color(0xFF81A4CD);
  final Color iceberg = const Color(0xFFDBE4EE);
  final Color marigold = const Color(0xFFECA400);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                //decoration: BoxDecoration(color: Colors.blue),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(children: [
                    CircleAvatar(
                      child: Image.asset('images/profile.png'),
                      radius: 50,
                    ),
                    SizedBox(width: 20),
                    Container(
                      //decoration: BoxDecoration(color: Colors.yellow),
                      height: 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                              child: Text(
                            'ADMIN',
                            style: TextStyle(
                              color: oxford,
                              fontFamily: "SF_Pro_Rounded",
                              fontWeight: FontWeight.w700,
                              fontSize: 22.0,
                            ),
                          )),
                          Text(
                            'AdminXX@e.ntu.edu.sg',
                            style: TextStyle(
                              color: Color(0x99001D4A),
                              fontFamily: "SF_Pro_Rounded",
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 6,
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        IntrinsicHeight(
                          child: Text(
                            "My Account",
                            style: TextStyle(
                              color: oxford,
                              fontFamily: "SF_Pro_Rounded",
                              fontWeight: FontWeight.w700,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        _options(context: context, option: 'Change Password'),
                        _options(context: context, option: 'User Feedback'),
                        _options(context: context, option: 'Alert')
                      ]),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              width: 150,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(38.0),
                ),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginRegisterScreen()));
                },
                padding: EdgeInsets.all(10.0),
                color: marigold,
                textColor: white,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Icon(Icons.logout),
                  ),
                  Text(
                    "Logout",
                    style:
                        TextStyle(fontSize: 15, fontFamily: "SF_Pro_Rounded"),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _options({required BuildContext context, required String option}) {
    return IntrinsicHeight(
      child: Column(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              if (option == 'Change Password') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ChangePasscodePage()),
                );
              } else if (option == 'User Feedback') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AdminUserFeedbackPage()),
                );
              } else if (option == 'Alert') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AdminAlertPage()),
                );
              }
            },
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    option,
                    style: TextStyle(
                      color: oxford,
                      fontFamily: "SF_Pro_Rounded",
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: oxford,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1,
            color: iceberg,
            height: 30,
          )
        ],
      ),
    );
  }
}
