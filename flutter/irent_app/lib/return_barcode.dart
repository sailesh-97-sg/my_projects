import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert';

class return_barcode extends StatefulWidget {
  final Color white = const Color(0xFFFBFBFF);
  final Color oxford = const Color(0xFF001D4A);
  final Color aliceblue = const Color(0xFF81A4CD);
  final Color iceberg = const Color(0xFFDBE4EE);
  final Color marigold = const Color(0xFFECA400);
  final Color transparent = const Color(0x4DE3E3E3);

  final String box_id;
  final String store_id;
  final String ticketNumber;

  const return_barcode(
      {Key? key,
      required this.store_id,
      required this.box_id,
      required this.ticketNumber})
      : super(key: key);

  @override
  State<return_barcode> createState() => _return_barcodeState();
}

class _return_barcodeState extends State<return_barcode> {
  final controller = TextEditingController();

  String thekey = "";
  String thestatus = "";

  void initState() {
    CollectionReference keyCollection =
        FirebaseFirestore.instance.collection('Key');
    keyCollection.doc('user').snapshots().listen((event) {
      try {
        setState(() {
          thekey = event.get(FieldPath(['value']));
        });
      } on StateError catch (e) {
        print('No nested field exists!');
      }
    });
    CollectionReference statusCollection =
        FirebaseFirestore.instance.collection('transactions');
    statusCollection.doc(widget.ticketNumber).snapshots().listen((event) {
      try {
        setState(() {
          thestatus = event.get(FieldPath(['status']));
        });
      } on StateError catch (e) {
        print('No nested field exists!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map userQR = {
      'username': FirebaseAuth.instance.currentUser!.email,
      'key': thekey,
      'status': 'completed',
      'ticketNumber': widget.ticketNumber.toString(),
      'box': widget.box_id.toString(),
    };
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Return',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromRGBO(0, 29, 74, 1),
              fontFamily: 'SF_Pro_Rounded',
              fontSize: 25,
              fontWeight: FontWeight.w500),
        ),
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'Scan this QR code \nto return your item',
            style: TextStyle(
                color: Color(0xFF001D4A),
                fontFamily: 'SF_Pro_Rounded',
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
          Container(
              padding: EdgeInsets.only(top: 40),
              child: QrImage(
                data: json.encode(userQR),
                size: 350,
              )),
          Container(
              padding: EdgeInsets.only(top: 40),
              child: Text('Return at',
                  style: TextStyle(
                      color: Color(0xFF001D4A),
                      fontFamily: 'SF_Pro_Rounded',
                      fontSize: 20,
                      fontWeight: FontWeight.w700))),
          Container(
              child: Text(
            'Box #${widget.box_id}',
            style: TextStyle(
                color: Color(0xFF001D4A),
                fontFamily: 'SF_Pro_Rounded',
                fontSize: 20,
                fontWeight: FontWeight.w500),
          )),
        ]),
      ),
    );
  }
}
