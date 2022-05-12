import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:irent_app/app_icons.dart';
import 'package:irent_app/database.dart';
import 'package:irent_app/user_store_uroc.dart';
import 'login_register.dart';

enum PaymentType { paylah, paynow }

class TopUpPage extends StatefulWidget {
  const TopUpPage({Key? key}) : super(key: key);

  @override
  State<TopUpPage> createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  String? uid = FirebaseAuth.instance.currentUser?.uid;
  CollectionReference updateWallet =
      FirebaseFirestore.instance.collection('users');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _amountField = TextEditingController();

  final Color white = const Color(0xFFFBFBFF);
  final Color oxford = const Color(0xFF001D4A);
  final Color aliceblue = const Color(0xFF81A4CD);
  final Color iceberg = const Color(0xFFDBE4EE);
  final Color marigold = const Color(0xFFECA400);
  final TextStyle titleStyle = const TextStyle(
    fontFamily: "SF_Pro_Rounded",
    color: Color(0xFF001D4A),
    fontSize: 25,
    fontWeight: FontWeight.w500,
  );
  final TextStyle subtitleStyle = const TextStyle(
    fontFamily: "SF_Pro_Rounded",
    color: Color(0xFF001D4A),
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );
  final TextStyle amountStyle = const TextStyle(
    fontFamily: "SF_Pro_Rounded",
    color: Color(0xFF001D4A),
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );
  String? currentuser = FirebaseAuth.instance.currentUser?.email;

  PaymentType? _paymentType = PaymentType.paylah;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: white,
        centerTitle: true,
        title: Text(
          'Top Up',
          style: titleStyle,
        ),
        elevation: 0,
        leading: Row(
          children: [
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                size: 32,
                color: oxford,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Payment Method',
              style: subtitleStyle,
            ),
            SizedBox(height: 15),
            _radioButton(
                option: 'PayLah!',
                value: PaymentType.paylah,
                image: 'images/paylah.png'),
            SizedBox(height: 15),
            _radioButton(
                option: 'PayNow',
                value: PaymentType.paynow,
                image: 'images/payanyone.png'),
            SizedBox(
              height: 30,
            ),
            Text(
              'Amount',
              style: subtitleStyle,
            ),
            Form(
              key: _formKey,
              child: TextField(
                controller: _amountField,
                decoration: const InputDecoration(
                  hintText: "Enter top up amount",
                  hintStyle: TextStyle(
                    fontFamily: "SF_Pro_Rounded",
                    color: Color(0x66001D4A),
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
                      color: Color(0xFF001D4A),
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                style: amountStyle,
                textAlign: TextAlign.right,
                keyboardType: TextInputType.numberWithOptions(signed: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ], // Only numbers can be entered
              ),
            ),
            Expanded(
              child: Align(
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
                            color: white,
                            fontFamily: 'SF_Pro_Rounded',
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xFFECA400),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(38))),
                    ),
                  ),
                ),
              ),
            ),
          ],
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
        color: iceberg,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 5),
          ),
        ],
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
                  color: oxford),
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
        activeColor: oxford,
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
