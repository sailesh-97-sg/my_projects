import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:irent_app/app_icons.dart';
import 'package:irent_app/checkbox.dart';
import 'package:irent_app/date.dart';
import 'increment_decrement.dart';
import 'package:irent_app/switch_nav.dart';
import 'package:irent_app/time.dart';
import 'homepage.dart';
import 'constants.dart';
import 'user_payment.dart';
import 'package:irent_app/switch_nav.dart';
import 'dart:math';

final FirebaseAuth _auth = FirebaseAuth.instance;

class basket extends StatefulWidget {
  const basket({Key? key}) : super(key: key);

  @override
  State<basket> createState() => _basketState();
}

class _basketState extends State<basket> {
  DateTime? _endDateTime;
  DateTime? _startdate;
  DateTime? _enddate;
  TimeOfDay? _starttime;
  TimeOfDay? _endtime;
  DateTime _dateTime1 = DateTime(2022);
  DateTime _dateTime2 = DateTime(2022);
  TimeOfDay _time = TimeOfDay.now();
  final Color white = const Color(0xFFFBFBFF);
  final Color oxford = const Color(0xFF001D4A);
  final Color aliceblue = const Color(0xFF81A4CD);
  final Color iceberg = const Color(0xFFDBE4EE);
  final Color marigold = const Color(0xFFECA400);
  final Color transparent = const Color(0x4DE3E3E3);

  List thebasket = [];
  int totalCost = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getBasket();
  }

  String? uid = FirebaseAuth.instance.currentUser?.uid;
  CollectionReference updateWallet =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: white,
        body: Column(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
            child: Text(
              'Basket',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: oxford,
                  fontFamily: 'SF_Pro_Rounded',
                  fontSize: 25,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: ListView.builder(
                  itemCount: thebasket.length,
                  itemBuilder: (context, index) {
                    // for (var product in thebasket) {
                    return _productDetails(
                        context: context,
                        name: thebasket[index].product_name.toString(),
                        startDateTime: thebasket[index].product_startDateTime,
                        endDateTime: thebasket[index].product_endDateTime,
                        product_category:
                            thebasket[index].product_category.toString(),
                        pricePerhour: int.parse(
                            thebasket[index].product_price.toString()),
                        product_id: thebasket[index].product_id.toString(),
                        displayPicture:
                            thebasket[index].product_displayPicture.toString(),
                        item_count: int.parse(
                            thebasket[index].product_count.toString()));
                    // }
                    // throw 'No Data Found';
                  }),
            ),
          ),
          Column(
            children: [
              Container(
                  margin: EdgeInsets.only(left: 20, top: 12.5),
                  alignment: Alignment.bottomCenter,
                  height: 100,
                  width: 412,
                  color: Color(0xFFFBFBFF),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 58,
                          width: 67,
                          child: Column(
                            children: [
                              Container(
                                  height: 21,
                                  width: 126,
                                  child: Text(
                                    'Total',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color(0xFF001D4A),
                                        fontFamily: 'SF Pro Rounded',
                                        fontSize: 16,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w500,
                                        height: 1),
                                  )),
                              Container(
                                  height: 25,
                                  width: 126,
                                  child: Text(
                                    '\$$totalCost',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Color(0xFF001D4A),
                                        fontFamily: 'SF Pro Rounded',
                                        fontSize: 30,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w500,
                                        height: 1),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: [
                            InkWell(
                              child: Container(
                                  margin: EdgeInsets.only(top: 22),
                                  height: 53,
                                  width: 140,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(32),
                                      topRight: Radius.circular(32),
                                      bottomLeft: Radius.circular(32),
                                      bottomRight: Radius.circular(32),
                                    ),
                                    color: Color.fromRGBO(236, 164, 0, 1),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Book',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                        fontFamily: 'SF Pro Rounded',
                                        fontSize: 18,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.normal,
                                        height: 1),
                                  )),
                              onTap: () {
                                decreaseWallet();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => user_payment()),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ]),
      ),
    );
  }

  getBasket() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('basket')
        .snapshots()
        .listen((data) {
      setState(() {
        thebasket = List.from(
            data.docs.map((doc) => BasketDataModel.fromSnapshot(doc)));
        for (var i = 0; i < thebasket.length; i++) {
          totalCost += int.parse(thebasket[i].product_price.toString()) *
              int.parse(thebasket[i].product_count.toString()) *
              int.parse(calcTime(thebasket[i].product_startDateTime,
                      thebasket[i].product_endDateTime)
                  .toString());
        }

        // storeData = newstores;
      });
    });
  }

  calcTime(Timestamp startDateTime, Timestamp endDateTime) {
    try {
      var borrowPeriod = DateTime.fromMillisecondsSinceEpoch(
              endDateTime.millisecondsSinceEpoch)
          .difference(DateTime.fromMillisecondsSinceEpoch(
              startDateTime.millisecondsSinceEpoch))
          .inHours;

      return borrowPeriod;
    } catch (e) {
      return 0;
    }
  }

  Widget _productDetails(
      {required BuildContext context,
      required String name,
      required String product_category,
      required int pricePerhour,
      required String displayPicture,
      required String product_id,
      required int item_count,
      required Timestamp startDateTime,
      required Timestamp endDateTime}) {
    final TextStyle subtitleStyles = TextStyle(
      fontFamily: 'SF_Pro_Rounded',
      fontSize: 15,
      fontWeight: FontWeight.w300,
      color: Color(0xFF001D4A),
      wordSpacing: 1,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Card(
        color: Color(0xFF81A4CD),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 1,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10.0, right: 10, top: 15, bottom: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: (Column(
                  children: [SizedBox()],
                )),
              ),
              Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: new DecorationImage(
                            image: NetworkImage(displayPicture),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  )),
              Expanded(
                flex: 11,
                child: ListTile(
                  title: Row(
                    children: [
                      Container(
                        width: 180,
                        child: Text(
                          name,
                          style: TextStyle(
                            fontFamily: 'SF_Pro_Rounded',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF001D4A),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: InkWell(
                            onTap: () {
                              showAlertDialog(
                                  context: context, product_id: product_id);
                            },
                            child: Container(
                              child: Icon(Icons.close),
                            )),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\$$pricePerhour /hour',
                        style: TextStyle(
                          fontFamily: 'SF_Pro_Rounded',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF001D4A),
                        ),
                      ),
                      Text('Start Date           End Date',
                          style: subtitleStyles),
                      Row(
                        children: [
                          Text(
                              '${DateFormat('dd/MM/yyyy').format(startDateTime.toDate())}         ${DateFormat('dd/MM/yyyy').format(endDateTime.toDate())}         ')
                        ],
                      ),
                      Text('Start Time           End Time',
                          style: subtitleStyles),
                      Row(
                        children: [
                          Text(
                              '${DateFormat('kk:mm').format(startDateTime.toDate())}                    ${DateFormat('kk:mm').format(endDateTime.toDate())}')
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            increment_decrement(itemCount: item_count)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog({required BuildContext context, required String product_id}) {
    // set up the buttons

    Widget noButton = TextButton(
      style: ElevatedButton.styleFrom(
          primary: const Color(0xFFFBFBFF),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(38))),
      child: Text(
        "No",
        style: TextStyle(
            color: Color(0xFF001D4A),
            fontFamily: 'SF_Pro_Rounded',
            fontSize: 18,
            fontWeight: FontWeight.w700),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    Widget yesButton = TextButton(
      style: ElevatedButton.styleFrom(
          primary: const Color(0xFF001D4A),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(38))),
      child: Text(
        "Yes",
        style: TextStyle(
            color: Color(0xFFFBFBFF),
            fontFamily: 'SF_Pro_Rounded',
            fontSize: 18,
            fontWeight: FontWeight.w700),
      ),
      onPressed: () {
        deleteItem(product_id);
        // getBasket();
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      backgroundColor: Color(0xFFDBE4EE),
      //title: Text("Notice"),
      content: Text("Do you want to remove this item?"),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 35, width: 100, child: noButton),
            SizedBox(height: 35, width: 100, child: yesButton),
          ],
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> decreaseWallet() {
    return updateWallet
        .doc(uid)
        .update({'wallet': FieldValue.increment(totalCost * -1)});
  }
}

Future<void> deleteItem(product_id) {
  DocumentReference selectitem = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('basket')
      .doc(product_id);
  return selectitem.delete();
}

// class BasketDataModel {
//   String product_id = "",
//       product_count = "",
//       product_displayPicture = "",
//       product_name = "",
//       product_category = "",
//       product_price = "",
//       product_startdate = "",
//       product_enddate = "",
//       product_starttime = "",
//       product_endtime = "",
//       product_startDateTime = "",
//       product_endDateTime = "",
//       product_box_id = "";

//   int product_box_number = 0;

//   BasketDataModel();
//   Map<String, dynamic> toJson() => {
//         'product_id': product_id,
//         'product_count': product_count,
//         'product_displayPicture': product_displayPicture,
//         'product_name': product_name,
//         'product_category': product_category,
//         'product_price': product_price,
//         'product_startdate': product_startdate,
//         'product_enddate': product_enddate,
//         'product_starttime': product_starttime,
//         'product_endtime': product_endtime,
//         'product_startDateTime': product_startDateTime.toString(),
//         'product_endDateTime': product_endDateTime.toString(),
//         'product_box_number': product_box_number,
//         'product_box_id': product_box_id,

//         // 'item_id': item_id,
//       };
//   BasketDataModel.fromSnapshot(snapshot)
//       : product_id = snapshot.id,
//         product_count = snapshot.data()['product_count'],
//         product_displayPicture = snapshot.data()['product_displayPicture'],
//         product_name = snapshot.data()['product_name'],
//         product_category = snapshot.data()['product_category'],
//         product_price = snapshot.data()['product_price'],
//         product_startdate = snapshot.data()['product_startdate'].toString(),
//         product_enddate = snapshot.data()['product_enddate'].toString(),
//         product_starttime = snapshot.data()['product_starttime'],
//         product_endtime = snapshot.data()['product_endtime'],
//         product_startDateTime = snapshot.data()['startDateTime'].toString(),
//         product_endDateTime = snapshot.data()['endDateTime'].toString(),
//         product_box_number = snapshot.data()['box_number'],
//         product_box_id = snapshot.data()['box_id'];
// }

class BasketDataModel {
  String product_id = "",
      product_count = "",
      product_displayPicture = "",
      product_name = "",
      product_category = "",
      product_price = "",
      product_startdate = "",
      product_enddate = "",
      product_starttime = "",
      product_endtime = "",
      storeId = "",
      storeName = "",
      product_box_id = "";

  int product_box_number = 0;

  Timestamp product_startDateTime = Timestamp.now(),
      product_endDateTime = Timestamp.now();
  // ticket_number = "";

  BasketDataModel();
  Map<String, dynamic> toJson() => {
        'product_id': product_id,
        'product_count': product_count,
        'product_displayPicture': product_displayPicture,
        'product_name': product_name,
        'product_category': product_category,
        'product_price': product_price,
        'product_startdate': product_startdate,
        'product_enddate': product_enddate,
        'product_starttime': product_starttime,
        'product_endtime': product_endtime,
        'product_startDateTime': product_startDateTime,
        'product_endDateTime': product_endDateTime,
        'storeId': storeId,
        'storeName': storeName,
        'product_box_number': product_box_number,
        'product_box_id': product_box_id,
        // 'ticket_number': ticket_number,
        // 'item_id': item_id,
      };
  BasketDataModel.fromSnapshot(snapshot)
      : product_id = snapshot.id,
        product_count = snapshot.data()['product_count'],
        product_displayPicture = snapshot.data()['product_displayPicture'],
        product_name = snapshot.data()['product_name'],
        product_category = snapshot.data()['product_category'],
        product_price = snapshot.data()['product_price'],
        product_startdate = snapshot.data()['product_startdate'].toString(),
        product_enddate = snapshot.data()['product_enddate'].toString(),
        product_starttime = snapshot.data()['product_starttime'],
        product_endtime = snapshot.data()['product_endtime'],
        product_startDateTime = snapshot.data()['startDateTime'],
        product_endDateTime = snapshot.data()['endDateTime'],
        storeName = snapshot.data()['storeName'],
        storeId = snapshot.data()['storeId'],
        product_box_number = snapshot.data()['box_number'],
        product_box_id = snapshot.data()['box_id'];

  // ticket_number = snapshot.data()['ticket_number'].toString();

}
