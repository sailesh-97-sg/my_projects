import 'dart:ui';
import 'package:irent_app/basket.dart';
import 'package:irent_app/database.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:irent_app/topup.dart';
import 'package:intl/intl.dart';
import 'package:irent_app/database.dart';
import 'package:irent_app/user_item_page.dart';

import 'constants.dart';

import 'constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:intl/intl.dart';

import 'package:irent_app/CategoriesScroller.dart';

class user_store_uroc extends StatefulWidget {
  const user_store_uroc({Key? key}) : super(key: key);

  @override
  _user_store_urocState createState() => _user_store_urocState();
}

class _user_store_urocState extends State<user_store_uroc> {
  @override
  final Color white = const Color(0xFFFBFBFF);
  final Color oxford = const Color(0xFF001D4A);
  final Color aliceblue = const Color(0xFF81A4CD);
  final Color marigold = const Color(0xFFECA400);
  bool closeTopContainer = false;

  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.30;

    var formatter = NumberFormat("#,##0.00", "en_US");

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'UROC',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromRGBO(0, 29, 74, 1),
              fontFamily: 'SF_Pro_Rounded',
              fontSize: 25,
              fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(25.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Stack(children: [
            Container(
                height: 82,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromRGBO(129, 164, 205, 1),
                )),
            Positioned(
              left: 10,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Text.rich(TextSpan(children: <InlineSpan>[
                  WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Icon(
                        Icons.account_balance_wallet_outlined,
                        color: const Color(0xFFFBFBFF),
                        size: 25,
                      )),
                  TextSpan(
                      text: '  Wallet',
                      style: TextStyle(
                          color: const Color(0xFFFBFBFF),
                          fontFamily: 'SF Pro Rounded',
                          fontSize: 20,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w500)),
                ])),
              ),
            ),
            Positioned(
                left: 10,
                top: 35,
                child: Container(
                  height: 28.25,
                  width: 126,
                  //color: Colors.black,
                  // child: FutureBuilder(
                  //   future: getUserInfo(),
                  //   builder: (BuildContext context,
                  //       AsyncSnapshot<DocumentSnapshot> snapshot) {
                  //     if (snapshot.hasData && snapshot.data!.exists) {
                  //       if (snapshot.connectionState ==
                  //           ConnectionState.waiting) {
                  //         return Center(
                  //           child: CircularProgressIndicator(),
                  //         );
                  //       } else {
                  //         Map<String, dynamic> data =
                  //             snapshot.data!.data() as Map<String, dynamic>;
                  //         return Text(
                  //           "\$" + formatter.format(data['wallet']),
                  //           textAlign: TextAlign.left,
                  //           style: TextStyle(
                  //             color: Color.fromRGBO(251, 251, 255, 1),
                  //             fontFamily: 'SF Pro Rounded',
                  //             fontSize: 25,
                  //             letterSpacing:
                  //                 0 /*percentages not used in flutter. defaulting to zero*/,
                  //             fontWeight: FontWeight.normal,
                  //           ),
                  //         );
                  //       }
                  //     } else if (snapshot.hasError) {
                  //       return Text('no data');
                  //     }
                  //     return CircularProgressIndicator();
                  //   },
                  // ),
                )),
            Positioned(
                left: 240,
                top: 25,
                child: InkWell(
                  child: Container(
                    width: 66,
                    height: 29,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromRGBO(39, 71, 110, 1),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Top Up',
                      style: TextStyle(
                        color: Color.fromRGBO(251, 251, 255, 1),
                        fontFamily: 'SF Pro Rounded',
                        fontSize: 12,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TopUpPage()),
                    );
                  },
                )),
          ]),
          Align(
            alignment: Alignment(-1.0, -1.0),
            child: Container(
              height: 35,
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                'Categories',
                style: TextStyle(
                    color: const Color(0xFF001D4A),
                    fontFamily: 'SF Pro Rounded',
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                    height: 1),
              ),
            ),
          ),
          CategoriesScroller(),
          Expanded(
            //flex: 8,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: GridView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: productDetails.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    for (var product in productDetails) {
                      return _productDetailsCard(
                          context: context,
                          name: productDetails[index]['name'].toString(),
                          product_category: productDetails[index]
                                  ['product_category']
                              .toString(),
                          pricePerhour: int.parse(
                              productDetails[index]['pricePerhour'].toString()),
                          displayPicture: productDetails[index]
                                  ['displayPicture']
                              .toString());
                    }
                    throw 'No Data Found';
                  }),
            ),
          ),
        ]),
      ),
    );
  }
}

Widget _productDetailsCard(
    {required BuildContext context,
    required String name,
    required String product_category,
    required int pricePerhour,
    required String displayPicture}) {
  return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: new DecorationImage(
                image: AssetImage(displayPicture),
                fit: BoxFit.cover,
              ),
            ),
          )));
}
