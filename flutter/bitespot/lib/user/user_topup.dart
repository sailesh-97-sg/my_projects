// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

enum PaymentType { paylah, paynow }

class TopupPage extends StatefulWidget {
  const TopupPage({Key? key}) : super(key: key);

  @override
  State<TopupPage> createState() => _TopupPageState();
}

class _TopupPageState extends State<TopupPage> {
  String? uid = FirebaseAuth.instance.currentUser!.uid;
  CollectionReference updateWallet =
      FirebaseFirestore.instance.collection('users');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _amountField = TextEditingController();
  String? currentUser = FirebaseAuth.instance.currentUser?.email;
  PaymentType? _paymentType = PaymentType.paylah;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Topup Page', style: TextStyle(color: Colors.white))),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Center(
                child: Container(
                    padding: EdgeInsets.all(10),
                    height: 150,
                    child: Lottie.asset('assets/walletanimation.json')),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Select Payment Method',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              _radioButton(
                  option: 'PayNow',
                  value: PaymentType.paynow,
                  image: 'assets/payanyone.png'),
              SizedBox(
                height: 15,
              ),
              _radioButton(
                  option: 'PayNow',
                  value: PaymentType.paylah,
                  image: 'assets/paylah.png'),
              SizedBox(
                height: 30,
              ),
              Text(
                'Amount',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Form(
                  key: _formKey,
                  child: TextField(
                    controller: _amountField,
                    decoration: const InputDecoration(
                      hintText: "Enter top up amount",
                      hintStyle: TextStyle(
                        fontFamily: "SF_Pro_Rounded",
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                      prefixIconConstraints: BoxConstraints(
                        minHeight: 32,
                        minWidth: 32,
                      ),
                      prefixIcon: Text(
                        '\$',
                        style: TextStyle(
                          fontFamily: "SF_Pro_Rounded",
                          color: Colors.grey,
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.numberWithOptions(signed: true),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  )),
              SizedBox(
                height: 100,
              ),
              Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: 25.0),
                      child: SizedBox(
                        width: 160,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            topUpWallet();
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Confirm',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'SF_Pro_Rounded',
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 115, 194, 255),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(38))),
                        ),
                      )))
            ],
          ),
        ),
      ),
    );
  }

  Widget _radioButton(
      {required String option,
      required PaymentType value,
      required String image}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black87,
      ),
      child: RadioListTile<PaymentType>(
        title: Row(
          children: [
            Image.asset(
              image,
              width: 50,
              height: 50,
            ),
            Text(
              option,
              style: TextStyle(
                  fontFamily: 'SF_Pro_Rounded',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
          ],
        ),
        value: value,
        groupValue: _paymentType,
        onChanged: (PaymentType? value) {
          setState(() {
            _paymentType = value;
          });
        },
        activeColor: Colors.blue,
        controlAffinity: ListTileControlAffinity.trailing,
      ),
    );
  }

  Future<void> topUpWallet() {
    return updateWallet
        .doc(uid)
        .update({'wallet': FieldValue.increment(int.parse(_amountField.text))});
  }
}
