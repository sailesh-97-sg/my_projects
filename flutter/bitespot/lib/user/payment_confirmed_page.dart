// ignore_for_file: prefer_const_constructors

import 'package:bitespot/user/home_page.dart';
import 'package:bitespot/user/user_homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PaymentConfirmedPage extends StatefulWidget {
  final storeUUID;
  final storeName;
  const PaymentConfirmedPage({Key? key, this.storeUUID, this.storeName})
      : super(key: key);

  @override
  State<PaymentConfirmedPage> createState() => _PaymentConfirmedPageState();
}

final user = FirebaseAuth.instance.currentUser!;
final userName = FirebaseAuth.instance.currentUser!.displayName;

class _PaymentConfirmedPageState extends State<PaymentConfirmedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Payment Confirmed',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.grey[850],
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/payment_success.json', repeat: false),
              SizedBox(
                height: 20,
              ),
              Text(
                'Please proceed back to the main page.',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text('Home Screen'),
                onPressed: () {
                  deleteBasket().then((value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      )));
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
              )
            ],
          ))),
    );
  }

  Future deleteBasket() async {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('basket')
          .doc(widget.storeUUID)
          .update({
        'basketMap': FieldValue.delete(),
        'totalCost': FieldValue.delete(),
        'quantity': 0,
        'basketLength': FieldValue.delete()
      });
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}
