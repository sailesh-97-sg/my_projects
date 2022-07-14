// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseUserInfo extends StatefulWidget {
  const FirebaseUserInfo({Key? key}) : super(key: key);

  @override
  State<FirebaseUserInfo> createState() => _FirebaseUserInfoState();
}

class _FirebaseUserInfoState extends State<FirebaseUserInfo> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data!.exists) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Text(data['email']);
          }
        } else if (snapshot.hasError) {
          return Text('There has been an error');
        } else if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        throw '';
      },
    );
  }
}
