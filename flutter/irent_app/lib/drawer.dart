// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'login_register.dart';
import 'database.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(left: 30, top: 30),
          child: Container(
            height: 200,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasData && snapshot.data!.exists) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                    return Center(
                        // here only return is missing
                        child: Text(data['name']));
                  }
                } else if (snapshot.hasError) {
                  return Text('no data');
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ),
        ListTile(
          iconColor: Colors.white,
          textColor: Colors.white,
          title: const Text('Home'),
          leading: Icon(Icons.home),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        SizedBox(
          height: 20,
        ),
        ListTile(
          iconColor: Colors.white,
          textColor: Colors.white,
          title: const Text('Account'),
          leading: Icon(Icons.person),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        SizedBox(
          height: 20,
        ),
        ListTile(
          iconColor: Colors.white,
          textColor: Colors.white,
          title: const Text('History'),
          leading: Icon(Icons.calendar_view_day_rounded),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        SizedBox(
          height: 20,
        ),
        ListTile(
          iconColor: Colors.white,
          textColor: Colors.white,
          title: const Text('Feedback'),
          leading: Icon(Icons.feedback),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        Container(
          padding: EdgeInsets.only(right: 90, left: 20),
          margin: EdgeInsets.only(top: 120),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.grey.shade300,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginRegisterScreen()));
              },
              child: Text('Sign Out')),
        ),
      ],
    ));
  }
}
