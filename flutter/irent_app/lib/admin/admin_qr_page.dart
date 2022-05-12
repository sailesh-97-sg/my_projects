import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:irent_app/app_icons.dart';
import 'package:irent_app/database.dart';
import 'package:irent_app/switch_nav.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'admin_constants.dart';
import 'dart:convert';

class AdminQRPage extends StatefulWidget {
  final item_id;
  final store_id;
  final box_number;

  const AdminQRPage(
      {Key? key,
      required this.item_id,
      required this.store_id,
      required this.box_number})
      : super(key: key);
  @override
  _AdminQRPageState createState() => _AdminQRPageState();
}

class _AdminQRPageState extends State<AdminQRPage> {
  final Color white = const Color(0xFFFBFBFF);
  final Color oxford = const Color(0xFF001D4A);
  final Color aliceblue = const Color(0xFF81A4CD);
  final Color marigold = const Color(0xFFECA400);

  String thekey = "";
  @override
  Widget build(BuildContext context) {
    final Map adminQR = {
      'username': 'admin',
      'key': thekey,
      'status': '0',
      'store': '0',
      'box': widget.box_number,
    };
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
                "Scan this QR code\nto open the locker.",
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
                data: json.encode(adminQR),
                size: 350,
                backgroundColor: white,
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Place Item(s) at:",
                style: TextStyle(
                    color: oxford,
                    fontSize: 20,
                    fontFamily: 'SF_Pro_Rounded',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1),
              ),
              Text(
                "Box #${adminQR['box']}",
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
//     Future getQRData() async {
//     var keyvalue = await FirebaseFirestore.instance
//         .collection('Key')
//         .doc('admin')
//         .get();

//     List thekeyvalue =
//         List.from(keyvalue.docs.map((doc) => KeyModel.fromSnapshot(doc)));
// }
  @override
  void initState() {
    CollectionReference keyCollection =
        FirebaseFirestore.instance.collection('Key');
    keyCollection.doc('admin').get().then((DocumentSnapshot datas) {
      try {
        setState(() {
          thekey = datas.get(FieldPath(['value']));
        });
      } on StateError catch (e) {
        print('No nested field exists!');
      }
    });
    super.initState();
  }
}
