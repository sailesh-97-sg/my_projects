// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:bitespot/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrganizationProfilePage extends StatefulWidget {
  const OrganizationProfilePage({Key? key}) : super(key: key);

  @override
  State<OrganizationProfilePage> createState() =>
      _OrganizationProfilePageState();
}

class _OrganizationProfilePageState extends State<OrganizationProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.displayName!,
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold)),
                    Text(user.email!, style: TextStyle(fontSize: 20))
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text(
              'General',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            width: double.infinity,
            height: 46,
            child: Card(
              color: Color.fromARGB(255, 20, 20, 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Change Password',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            width: double.infinity,
            height: 46,
            child: Card(
              color: Color.fromARGB(255, 20, 20, 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Change Email',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            width: double.infinity,
            height: 46,
            child: Card(
              color: Color.fromARGB(255, 20, 20, 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Update UUID ',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text(
              'About',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            width: double.infinity,
            height: 46,
            child: Card(
              color: Color.fromARGB(255, 20, 20, 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Submit Feedback',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            width: double.infinity,
            height: 46,
            child: Card(
              color: Color.fromARGB(255, 20, 20, 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Contact Us',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          // ignore: prefer_const_constructors
          SizedBox(
            height: 25,
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                side: BorderSide(width: 2, color: Colors.black),
                minimumSize: Size.fromHeight(46),
                primary: Color.fromARGB(255, 168, 210, 255),
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            icon: Icon(
              Icons.arrow_back,
              size: 32,
              color: Colors.black,
            ),
            label: Text(
              'Sign Out',
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
            onPressed: () => FirebaseAuth.instance.signOut().then((value) =>
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()),
                    (Route<dynamic> route) => false)),
          )
        ],
      ),
    );
  }
}
