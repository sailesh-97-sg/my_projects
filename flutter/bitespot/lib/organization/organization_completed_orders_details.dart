// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new

import 'dart:convert';

import 'package:flutter/material.dart';

class CompletedOrderDetails extends StatefulWidget {
  final orderNumber;
  final Map basketMap;
  final userEmail;
  final totalCost;
  final userID;
  final tableNumber;
  const CompletedOrderDetails(
      {Key? key,
      required this.tableNumber,
      required this.userEmail,
      required this.orderNumber,
      required this.basketMap,
      required this.totalCost,
      required this.userID})
      : super(key: key);

  @override
  State<CompletedOrderDetails> createState() => _CompletedOrderDetailsState();
}

class _CompletedOrderDetailsState extends State<CompletedOrderDetails> {
  @override
  Widget build(BuildContext context) {
    var myMapValues = widget.basketMap;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
              'Order No: #' + (widget.orderNumber),
            )),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Order No: #' + widget.orderNumber,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: new TextSpan(
                            style: new TextStyle(color: Colors.black),
                            children: [
                          TextSpan(
                              text: "Email: ",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: widget.userEmail,
                          )
                        ])),
                    SizedBox(
                      height: 10,
                    ),
                    RichText(
                        text: new TextSpan(
                            style: new TextStyle(color: Colors.black),
                            children: [
                          TextSpan(
                              text: "Table No: ",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: widget.tableNumber,
                          )
                        ]))
                  ]),
            ),
            Divider(
              color: Colors.grey,
              thickness: 2,
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
                        child: Text('Name',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                          flex: 2,
                          child: Text('Quantity',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          flex: 2,
                          child: Text('Price',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))),
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, index) {
                      return Column(children: [
                        myMapValues.values.elementAt(index)[1] != 0
                            ? Row(
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Text(
                                      myMapValues.keys
                                          .elementAt(index)
                                          .toString(),
                                      style: TextStyle(color: Colors.black),
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
                                      style: TextStyle(color: Colors.black),
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
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  )
                                ],
                              )
                            : Container()
                      ]);
                    },
                    itemCount: myMapValues.length,
                  )
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
                              color: Colors.black, fontWeight: FontWeight.bold),
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
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          '\$' + widget.totalCost.toString(),
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        )));
  }
}
