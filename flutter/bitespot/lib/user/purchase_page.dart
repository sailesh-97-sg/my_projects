// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:convert';
import 'dart:math';

import 'package:bitespot/main.dart';
import 'package:bitespot/user/payment_confirmed_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class PurchasePage extends StatefulWidget {
  final storeName;
  final storeUUID;
  final Map basketMap;
  final totalCost;
  const PurchasePage(
      {Key? key,
      this.storeUUID,
      this.storeName,
      required this.basketMap,
      this.totalCost})
      : super(key: key);

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

final user = FirebaseAuth.instance.currentUser!;
final userName = FirebaseAuth.instance.currentUser!.displayName;

class _PurchasePageState extends State<PurchasePage> {
  CollectionReference updateWallet =
      FirebaseFirestore.instance.collection('users');
  String? uid = FirebaseAuth.instance.currentUser!.uid;
  final tableEditingController = TextEditingController();
  final requestsEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool? sufficientBalance;

  num totalCost = 0;
  final tableNumberEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        title: Text('Purchase Page'),
        backgroundColor: Colors.black,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('basket')
            .doc(widget.storeUUID)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data!.exists) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              var myMapValues = jsonDecode(data['basketMap']);
              totalCost = data['totalCost'];

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(widget.storeName,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic)),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Expanded(
                                flex: 6,
                                child: Text(
                                  'Name',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Quantity',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Price',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, index) {
                              return Column(
                                children: [
                                  myMapValues.values.elementAt(index)[1] != 0
                                      ? Row(
                                          children: [
                                            Expanded(
                                              flex: 6,
                                              child: Text(
                                                myMapValues.keys
                                                    .elementAt(index)
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                'x' +
                                                    myMapValues.values
                                                        .elementAt(index)[1]
                                                        .toString(),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                '\$ ' +
                                                    myMapValues.values
                                                        .elementAt(index)[0]
                                                        .toString(),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container(),
                                ],
                              );
                            },
                            itemCount: myMapValues.length,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(
                            color: Colors.grey,
                            thickness: 2,
                          ),
                          Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Expanded(
                                flex: 6,
                                child: Text(
                                  '',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  '',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  '\$' + data['totalCost'].toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Text(
                                      'Table: ',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    SizedBox(
                                      width: 60,
                                      height: 25,
                                      child: TextFormField(
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                        controller: tableEditingController,
                                        decoration: InputDecoration(
                                            labelStyle:
                                                TextStyle(color: Colors.white),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    width: 1,
                                                    color: Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(11)),
                                            errorBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    width: 3,
                                                    color: Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(11)),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                      width: 3,
                                                      color: Color.fromARGB(
                                                          255, 254, 223, 50),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            11)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  width: 1,
                                                  color: Color.fromARGB(
                                                      255, 254, 223, 50),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(11))),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Text(
                                      'Requests: ',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    Container(
                                      width: 200,
                                      height: 65,
                                      child: TextFormField(
                                        expands: true,
                                        maxLines: null,
                                        keyboardType: TextInputType.multiline,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                        controller: requestsEditingController,
                                        decoration: InputDecoration(
                                            labelStyle:
                                                TextStyle(color: Colors.white),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    width: 1,
                                                    color: Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(11)),
                                            errorBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    width: 3,
                                                    color: Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(11)),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                      width: 3,
                                                      color: Color.fromARGB(
                                                          255, 254, 223, 50),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            11)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  width: 1,
                                                  color: Color.fromARGB(
                                                      255, 254, 223, 50),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(11))),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(
                            color: Colors.white,
                            thickness: 2,
                          ),
                        ],
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        padding: EdgeInsets.all(10),
                        child: Card(
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                Image.asset('assets/wallet.png'),
                                Text(
                                  'Wallet: ',
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(user.uid)
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          snapshot) {
                                    if (snapshot.hasData &&
                                        snapshot.data!.exists) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      } else {
                                        Map<String, dynamic> data =
                                            snapshot.data!.data()
                                                as Map<String, dynamic>;
                                        if (data['wallet'] > totalCost) {
                                          sufficientBalance = true;
                                        } else {
                                          sufficientBalance = false;
                                        }

                                        return Row(
                                          children: [
                                            Text(
                                              '\$ ' + data['wallet'].toString(),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            data['wallet'] > totalCost
                                                ? Text(
                                                    'Sufficient Balance',
                                                    style: TextStyle(
                                                        color: Colors.yellow,
                                                        fontStyle:
                                                            FontStyle.italic),
                                                  )
                                                : Text(
                                                    'Insufficient Balance',
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontStyle:
                                                            FontStyle.italic),
                                                  )
                                          ],
                                        );
                                      }
                                    } else {
                                      return CircularProgressIndicator();
                                    }
                                    throw '';
                                  },
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                          ),
                        )),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.uid)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasData && snapshot.data!.exists) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else {
                              Map<String, dynamic> data =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              if (data['wallet'] > totalCost) {
                                sufficientBalance = true;
                              } else {
                                sufficientBalance = false;
                              }
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(10),
                                  height: 50,
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        data['wallet'] > totalCost
                                            ? await addToOngoingOrdersUser()
                                                .then((value) => deductWallet()
                                                    .then((value) => Navigator
                                                        .pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        PaymentConfirmedPage(
                                                                          storeName:
                                                                              widget.storeName,
                                                                          storeUUID:
                                                                              widget.storeUUID,
                                                                        )))))
                                            : ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Insufficient Balance!')));
                                      },
                                      child: Text(
                                        'Purchase',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      )));
                            }
                          } else {
                            return CircularProgressIndicator();
                          }
                          throw '';
                        }),
                  ],
                ),
              );
            }
          } else if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(child: CircularProgressIndicator());
          }
          throw '';
        },
      ),
    );
  }

  Future<void> deductWallet() {
    return updateWallet
        .doc(uid)
        .update({'wallet': FieldValue.increment(totalCost * -1)});
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

  Future addToOngoingOrdersUser() async {
    try {
      var randomNumber = Random().nextInt(200).toString();
      var data = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      FirebaseFirestore.instance
          .collection('stores')
          .doc(widget.storeUUID)
          .collection('ongoing_orders')
          .doc(DateFormat('dd-MM-yyyy_KK:mm:ss #' + randomNumber)
              .format(DateTime.now())
              .toString())
          .set({
        'price': totalCost,
        'email': user.email,
        'user_ID': user.uid,
        'itemsPurchased': jsonEncode(widget.basketMap),
        'time_purchased': Timestamp.fromDate(
          DateTime.now(),
        ),
        'table_number': tableEditingController.text,
        'store_name': widget.storeName,
        'order_number': randomNumber,
        'time_information': DateFormat('dd-MM-yyyy_KK:mm:ss #' + randomNumber)
            .format(DateTime.now())
            .toString()
      });
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('ongoing_orders')
          .doc(DateFormat('dd-MM-yyyy_KK:mm:ss #' + randomNumber)
              .format(DateTime.now())
              .toString())
          .set({
        'price': totalCost,
        'email': user.email,
        'user_ID': user.uid,
        'itemsPurchased': jsonEncode(widget.basketMap),
        'time_purchased': Timestamp.fromDate(
          DateTime.now(),
        ),
        'table_number': tableEditingController.text,
        'store_name': widget.storeName,
        'order_number': randomNumber,
        'time_information': DateFormat('dd-MM-yyyy_KK:mm:ss #' + randomNumber)
            .format(DateTime.now())
            .toString()
      });
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}
