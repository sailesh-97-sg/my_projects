// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:irent_app/about_us.dart';
import 'package:irent_app/change_passcode.dart';
import 'package:irent_app/edit_profile.dart';
import 'package:irent_app/feedback.dart';
import 'package:irent_app/history.dart';

import 'login_register.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final Color white = const Color(0xFFFBFBFF);

  final Color oxford = const Color(0xFF001D4A);

  final Color aliceblue = const Color(0xFF81A4CD);

  final Color marigold = const Color(0xFFECA400);

  String? uid = FirebaseAuth.instance.currentUser?.uid;

  String? currentuserEmail = FirebaseAuth.instance.currentUser?.email;

  String? currentuserName = FirebaseAuth.instance.currentUser?.displayName;

  CollectionReference nameref = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
            left: 25.0, right: 25.0, bottom: 25.0, top: 10),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                //decoration: BoxDecoration(color: Colors.blue),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(children: [
                    StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(uid)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong...');
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text('Loading...');
                        }
                        if (snapshot.hasData) {
                          return Row(children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(snapshot.data!['profileURL']),
                              radius: 50,
                            ),
                            SizedBox(width: 20),
                            Container(
                                //decoration: BoxDecoration(color: Colors.yellow),
                                height: 50,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        snapshot.data!['name'],
                                        style: TextStyle(
                                            color: oxford,
                                            fontFamily: "SF_Pro_Rounded",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 22.0),
                                      ),
                                      Text(
                                        snapshot.data!['email'],
                                        style: TextStyle(
                                          color: Color(0x99001D4A),
                                          fontFamily: "SF_Pro_Rounded",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ]))
                          ]);
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ]),
                ),
              ),
            ),
            SizedBox(
              height: screenheight * 0.01,
            ),
            Expanded(
              flex: 3,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                //decoration: BoxDecoration(color: Colors.blue),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
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
                        _options(context: context, option: 'My Profile'),
                        _options(context: context, option: 'Change Password'),
                        _options(context: context, option: 'History'),
                      ]),
                ),
              ),
            ),
            SizedBox(
              height: screenheight * 0.01,
            ),
            Expanded(
              flex: 3,
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  //decoration: BoxDecoration(color: Colors.blue),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Support",
                              style: TextStyle(
                                color: oxford,
                                fontFamily: "SF_Pro_Rounded",
                                fontWeight: FontWeight.w700,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          _options(context: context, option: 'About Us'),
                          _options(context: context, option: 'Feedback'),
                          Expanded(flex: 1, child: SizedBox()),
                        ]),
                  )),
            ),
            SizedBox(
              height: screenheight * 0.07,
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
                    // ignore: prefer_const_literals_to_create_immutables
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
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: Color(0x8081A4CD)),
          ),
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            if (option == 'My Profile') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const EditProfilePage()),
              );
            } else if (option == 'Change Password') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ChangePasscodePage()),
              );
            } else if (option == 'History') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistoryPage()),
              );
            } else if (option == 'About Us') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutUsPage()),
              );
            } else if (option == 'Feedback') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FeedbackPage()),
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
      ),
    );
  }
}
