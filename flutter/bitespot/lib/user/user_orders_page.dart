// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'ongoing_order_description.dart';

class UserOrdersPage extends StatefulWidget {
  const UserOrdersPage({Key? key}) : super(key: key);

  @override
  State<UserOrdersPage> createState() => _UserOrdersPageState();
}

final user = FirebaseAuth.instance.currentUser!.uid;

class _UserOrdersPageState extends State<UserOrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text('Ongoing Orders',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
          ),
          Expanded(
              flex: 8,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('ongoing_orders')
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
                              height: 110,
                              width: MediaQuery.of(context).size.width,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              OngoingOrderDescription(
                                                basketMap: jsonDecode(
                                                  thedata['itemsPurchased'],
                                                ),
                                                storeName:
                                                    thedata['store_name'],
                                                totalCost: thedata['price'],
                                              ))));
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  color: Colors.black,
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        Text(
                                            'Location: ' +
                                                thedata['store_name']
                                                    .toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                            'Order Number: #' +
                                                thedata['order_number'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                            'Date: ' +
                                                DateFormat('dd/MM/yyyy')
                                                    .format(thedata[
                                                            'time_purchased']
                                                        .toDate())
                                                    .toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                            'Table Number: ' +
                                                thedata['table_number'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                            'Price: \$' +
                                                thedata['price'].toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    }
                  })),
          Container(
            margin: EdgeInsets.only(left: 10, bottom: 10),
            child: Text('Completed Orders',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
          ),
          Expanded(
              flex: 10,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
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
                        DocumentSnapshot completeddata =
                            snapshot.data!.docs[index];
                        return Container(
                          height: 110,
                          width: MediaQuery.of(context).size.width,
                          child: GestureDetector(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              color: Color.fromARGB(255, 6, 1, 97),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Location: ' + completeddata['store'],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Order Number: # ' +
                                          completeddata['order_number'],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Date: ' +
                                          DateFormat('dd/MM/yyyy')
                                              .format(completeddata[
                                                      'time_purchased']
                                                  .toDate())
                                              .toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Table Number: ' +
                                          completeddata['table_number'],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Price: \$' +
                                          completeddata['price'].toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
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
                                          OngoingOrderDescription(
                                            basketMap: jsonDecode(
                                              completeddata['itemsPurchased'],
                                            ),
                                            storeName: completeddata['store'],
                                            totalCost: completeddata['price'],
                                          ))));
                            },
                          ),
                        );
                      },
                    );
                  }
                  throw '';
                },
              )),
        ],
      ),
    );
  }
}
