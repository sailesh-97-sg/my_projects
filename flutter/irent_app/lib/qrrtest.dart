// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:qr/qr.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrTest extends StatefulWidget {
  const QrTest({Key? key}) : super(key: key);

  @override
  _QrTestState createState() => _QrTestState();
}

class _QrTestState extends State<QrTest> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('QR Tester'),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.only(top: 50, left: 30, right: 30),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              QrImage(
                data: controller.text,
                size: 200,
              )
            ],
          ),
        ),
      ),
    );
  }
}
