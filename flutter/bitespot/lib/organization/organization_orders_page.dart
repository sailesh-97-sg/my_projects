// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:bitespot/organization/organization_ongoing_orders_details.dart';
import 'package:bitespot/user/payment_confirmed_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrganizationOrdersPage extends StatefulWidget {
  const OrganizationOrdersPage({Key? key}) : super(key: key);

  @override
  State<OrganizationOrdersPage> createState() => _OrganizationOrdersPageState();
}

class _OrganizationOrdersPageState extends State<OrganizationOrdersPage> {
  String? myStoreUUID;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ins();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      margin: EdgeInsets.only(top: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10),
            // ignore: prefer_const_constructors
            child: Text(
              'Completed Orders',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 1,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> uidsnapshot) {
                if (uidsnapshot.hasError) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (uidsnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('stores')
                        .doc(uidsnapshot.data!['uuid'])
                        .collection('completed_orders')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, index) {
                            DocumentSnapshot thedata =
                                snapshot.data!.docs[index];
                            return Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              child: GestureDetector(
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(
                                          color: Colors.black, width: 2)),
                                  color: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Order: #' + thedata['order_number'],
                                        ),
                                        Text('Date: ' +
                                            DateFormat('dd/MM/yyyy')
                                                .format(
                                                    thedata['time_purchased']
                                                        .toDate())
                                                .toString()),
                                        Text('Table: ' +
                                            thedata['table_number']),
                                        Text('Price: \$' +
                                            thedata['price'].toString()),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              OngoingOrderDetails(
                                                  tableNumber:
                                                      thedata['table_number'],
                                                  userEmail: thedata['email'],
                                                  orderNumber:
                                                      thedata['order_number'],
                                                  userID: thedata['user_ID'],
                                                  basketMap: jsonDecode(thedata[
                                                      'itemsPurchased']),
                                                  totalCost:
                                                      thedata['price']))));
                                },
                              ),
                            );
                          },
                        );
                      }
                      throw '';
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  // Future updateCompletedValue() async {
  //   try {
  //     var uuid = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .get();
  //     var data = await FirebaseFirestore.instance
  //         .collection('stores')
  //         .doc(uuid['uuid'])
  //         .get();
  //   } on FirebaseException catch (e) {}
  // }

  Future<void> ins() async {
    var myStores = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((data) {
      setState(() {
        String myStoreUUID = data['uuid'];
      });
    });
  }
}
