import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:irent_app/app_icons.dart';
import 'package:irent_app/database.dart';
import 'package:irent_app/switch_nav.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'constants.dart';
import 'dart:convert';

class UserQRPage extends StatefulWidget {
  const UserQRPage({Key? key}) : super(key: key);
  @override
  _UserQRPageState createState() => _UserQRPageState();
}

class _UserQRPageState extends State<UserQRPage> {
  final Color white = const Color(0xFFFBFBFF);
  final Color oxford = const Color(0xFF001D4A);
  final Color aliceblue = const Color(0xFF81A4CD);
  final Color marigold = const Color(0xFFECA400);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Place Item',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: oxford,
              fontFamily: 'SF_Pro_Rounded',
              fontSize: 25,
              fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Scan this QR code\nto collect your item.",
                style: TextStyle(
                    color: oxford,
                    fontSize: 20,
                    fontFamily: 'SF_Pro_Rounded',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1),
              ),
              SizedBox(
                height: 40,
              ),
              QrImage(
                data: json.encode(userQR),
                size: 200,
                backgroundColor: white,
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Collect at:",
                style: TextStyle(
                    color: oxford,
                    fontSize: 20,
                    fontFamily: 'SF_Pro_Rounded',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1),
              ),
              Text(
                "Box #${userQR['box']}",
                style: TextStyle(
                    color: oxford,
                    fontSize: 20,
                    fontFamily: 'SF_Pro_Rounded',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
