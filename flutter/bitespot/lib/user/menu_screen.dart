// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_typing_uninitialized_variables, unused_local_variable, avoid_print

import 'dart:convert';

import 'package:bitespot/user/purchase_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MenuScreen extends StatefulWidget {
  final storeUUID;
  final storeName;
  const MenuScreen({Key? key, this.storeUUID, this.storeName})
      : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final user = FirebaseAuth.instance.currentUser!;

  List checkoutList = [];
  int quantity = 0;
  num totalCost = 0;

  Map checkoutMap = {};

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Text('Discard Changes?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('No'),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              ElevatedButton(
                onPressed: () {
                  resetQuantity().then((value) => Navigator.pop(context, true));
                },
                child: Text('Yes'),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
              )
            ],
          ));

  @override
  Widget build(BuildContext context) {
    int checkoutListLength = checkoutList.length;
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showWarning(context);

        return shouldPop ?? false;
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          heroTag: "menuPage",
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .collection('basket')
                .doc(widget.storeUUID)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasData && snapshot.data!.exists) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                return Badge(
                    animationType: BadgeAnimationType.scale,
                    badgeContent: data['quantity'] != null
                        ? Text(data['quantity'].toString())
                        : Text('0'),
                    badgeColor: Color.fromARGB(255, 255, 87, 75),
                    showBadge: true,
                    child: Icon(Icons.shopping_bag));
              }
              throw '';
            },
          ),
          onPressed: () {
            quantity != 0
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PurchasePage(
                            storeName: widget.storeName,
                            storeUUID: widget.storeUUID,
                            basketMap: checkoutMap,
                            totalCost: totalCost)))
                : ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please select an item!')));
          },
          elevation: 4,
        ),
        backgroundColor: Colors.grey[850],
        appBar: AppBar(
          title: Text(widget.storeName),
          backgroundColor: Colors.black,
        ),
        body: Container(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('stores')
                .doc(widget.storeUUID)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;

                return ListView.builder(
                  itemBuilder: (BuildContext context, index) {
                    var pressedCounter = 0;

                    return Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              color: Colors.black,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Expanded(
                                      flex: 6,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data['menu']['itemNames'][index],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            data['menu']['itemDescriptions']
                                                [index],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'SGD \$' +
                                                    data['menu']['itemPrices']
                                                            [index]
                                                        .toString(),
                                                style: TextStyle(
                                                    color: Colors.yellow,
                                                    fontStyle: FontStyle.italic,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              StatefulBuilder(
                                                builder: (context, setState) =>
                                                    GestureDetector(
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: Colors.blue,
                                                  ),
                                                  onTap: () {
                                                    setState(() {
                                                      if (pressedCounter > 0) {
                                                        pressedCounter =
                                                            pressedCounter - 1;
                                                      }
                                                      if (totalCost > 0) {
                                                        totalCost = totalCost -
                                                            data['menu'][
                                                                    'itemPrices']
                                                                [index];
                                                      }

                                                      checkoutMap[data['menu']
                                                              ['itemNames']
                                                          [index]] = [
                                                        data['menu']
                                                                ['itemPrices']
                                                            [index],
                                                        pressedCounter
                                                      ];
                                                      List tempList = [
                                                        data['menu']
                                                                ['itemPrices']
                                                            [index],
                                                        data['menu']
                                                                ['itemNames']
                                                            [index],
                                                        pressedCounter
                                                      ];
                                                      checkoutList
                                                          .remove(tempList);
                                                      if (quantity > 0) {
                                                        quantity = quantity - 1;
                                                      }
                                                    });

                                                    print(checkoutList);
                                                    addBasket();
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              StatefulBuilder(
                                                builder: (context, setState) =>
                                                    GestureDetector(
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.blue,
                                                  ),
                                                  onTap: () {
                                                    setState(() {
                                                      pressedCounter =
                                                          pressedCounter + 1;

                                                      totalCost = totalCost +
                                                          data['menu']
                                                                  ['itemPrices']
                                                              [index];

                                                      checkoutMap[data['menu']
                                                              ['itemNames']
                                                          [index]] = [
                                                        data['menu']
                                                                ['itemPrices']
                                                            [index],
                                                        pressedCounter
                                                      ];
                                                      List tempList = [
                                                        data['menu']
                                                                ['itemPrices']
                                                            [index],
                                                        data['menu']
                                                                ['itemNames']
                                                            [index],
                                                        pressedCounter
                                                      ];
                                                      checkoutList
                                                          .add(tempList);
                                                      quantity = quantity + 1;
                                                    });

                                                    print(checkoutList);
                                                    addBasket();
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        flex: 4,
                                        child: StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(user.uid)
                                              .collection('basket')
                                              .doc(widget.storeUUID)
                                              .snapshots(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<DocumentSnapshot>
                                                  snapshot) {
                                            if (snapshot.hasData &&
                                                snapshot.data!.exists) {
                                              Map<String, dynamic> data =
                                                  snapshot.data!.data()
                                                      as Map<String, dynamic>;
                                              return Badge(
                                                badgeColor: Colors.white,
                                                animationType:
                                                    BadgeAnimationType.scale,
                                                badgeContent: Text(
                                                    pressedCounter.toString()),
                                                child: Image.network(
                                                    'https://www.mcdonalds.com.sg/sites/default/files/2021-09/Double%20McSpicy.png'),
                                              );
                                            } else {
                                              return CircularProgressIndicator();
                                            }
                                            throw '';
                                          },
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ]),
                    );
                  },
                  itemCount: data['menu']['itemNames'].length,
                );
              } else if (snapshot.hasError || !snapshot.hasData) {
                return Center(
                  child: Text(
                    'Sorry, the restaurant is currently closed.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                );
              }
              throw '';
            },
          ),
        ),
      ),
    );
  }

  Future addBasket() async {
    try {
      // FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(user.uid)
      //     .collection('basket')
      //     .doc(widget.storeUUID)
      //     .set({'checkoutBasket': jsonEncode(checkoutList)});
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('basket')
          .doc(widget.storeUUID)
          .update({'basketLength': checkoutList.length});
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('basket')
          .doc(widget.storeUUID)
          .update({'basketMap': jsonEncode(checkoutMap)});
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('basket')
          .doc(widget.storeUUID)
          .update({'quantity': quantity});
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('basket')
          .doc(widget.storeUUID)
          .update({'totalCost': totalCost});
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future resetQuantity() async {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('basket')
          .doc(widget.storeUUID)
          .set({'quantity': 0});
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future clearBasket() async {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('basket')
          .doc(widget.storeUUID)
          .delete();
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}
