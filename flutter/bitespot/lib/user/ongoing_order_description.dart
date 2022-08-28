// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';

class OngoingOrderDescription extends StatefulWidget {
  final storeName;
  final storeUUID;
  final Map basketMap;
  final totalCost;
  const OngoingOrderDescription(
      {Key? key,
      required this.storeName,
      this.storeUUID,
      required this.basketMap,
      required this.totalCost})
      : super(key: key);

  @override
  State<OngoingOrderDescription> createState() =>
      _OngoingOrderDescriptionState();
}

class _OngoingOrderDescriptionState extends State<OngoingOrderDescription> {
  @override
  Widget build(BuildContext context) {
    var myMapValues = widget.basketMap;
    return Scaffold(
        backgroundColor: Colors.grey[850],
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(widget.storeName),
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                widget.storeName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
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
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                          flex: 2,
                          child: Text('Quantity',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          flex: 2,
                          child: Text('Price',
                              style: TextStyle(
                                  color: Colors.white,
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
                                      style: TextStyle(color: Colors.white),
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
                                      style: TextStyle(color: Colors.white),
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
                                      style: TextStyle(color: Colors.white),
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
                              color: Colors.white, fontWeight: FontWeight.bold),
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
                              color: Colors.white, fontWeight: FontWeight.bold),
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
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        )));
  }
}
