import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:irent_app/time.dart';
import 'package:irent_app/user_payment_successful.dart';
//import '../size_config.dart';
import 'constants.dart';
import 'package:intl/intl.dart';
import 'user_bookings.dart';

class user_payment extends StatefulWidget {
  final product_displayPicture;
  final product_name;
  final product_category;
  final product_price;
  final product_count;
  final product_starttime;
  final product_endtime;
  final product_startdate;
  final product_enddate;
  user_payment(
      {this.product_displayPicture,
      this.product_name,
      this.product_category,
      this.product_price,
      this.product_count,
      this.product_enddate,
      this.product_endtime,
      this.product_startdate,
      this.product_starttime});

  @override
  _user_paymentState createState() => _user_paymentState();
}

class _user_paymentState extends State<user_payment> {
  final Color white = const Color(0xFFFBFBFF);
  final Color oxford = const Color(0xFF001D4A);
  final Color aliceblue = const Color(0xFF81A4CD);
  final Color iceberg = const Color(0xFFDBE4EE);
  final Color marigold = const Color(0xFFECA400);
  final Color transparent = const Color(0x4DE3E3E3);
  TextEditingController total = TextEditingController();

  getCustomFormattedDateTime(String givenDateTime, String dateFormat) {
    final DateTime docDateTime = DateTime.parse(givenDateTime);
    return DateFormat(dateFormat).format(docDateTime);
  }

  @override
  void initState() {
    super.initState();
    getBasket();
    getWallet();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  List thebooking = [];
  int totalCost = 0;
  int walletBalance = 0;

  bool? _success;
  String? _userEmail;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Payment',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromRGBO(0, 29, 74, 1),
              fontFamily: 'SF_Pro_Rounded',
              fontSize: 25,
              fontWeight: FontWeight.w500),
        ),
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(children: [
        Expanded(
          flex: 6,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: ListView.builder(
                itemCount: thebooking.length,
                itemBuilder: (context, index) {
                  return _historyCard(
                      context: context,
                      itemName: thebooking[index].product_name.toString(),
                      qty:
                          int.parse(thebooking[index].product_count.toString()),
                      pricePerhour:
                          int.parse(thebooking[index].product_price.toString()),
                      collectDate: thebooking[index].product_startDateTime,
                      returnDate: thebooking[index].product_endDateTime,
                      collectTime: thebooking[index].product_startDateTime,
                      returnTime: thebooking[index].product_endDateTime,
                      // ticketNumber: thebooking[index].ticket_number,
                      displayPicture:
                          thebooking[index].product_displayPicture.toString());
                }),
          ),
        ),
        Column(
          children: [
            Container(
                //margin: EdgeInsets.only(top: 201.5),
                alignment: Alignment.bottomCenter,
                height: 100,
                width: 412,
                color: Color(0xFF001D4A),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 30),
                      height: 80,
                      width: 80,
                      child: Column(
                        children: [
                          Container(
                              height: 30,
                              width: 130,
                              child: Text(
                                'Total:',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color.fromRGBO(251, 251, 255, 1),
                                    fontFamily: 'SF Pro Rounded',
                                    fontSize: 16,
                                    letterSpacing:
                                        0 /*percentages not used in flutter. defaulting to zero*/,
                                    fontWeight: FontWeight.normal,
                                    height: 1),
                              )),
                          Container(
                              height: 30,
                              width: 150,
                              child: Text(
                                '\$$totalCost',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color.fromRGBO(251, 251, 255, 1),
                                    fontFamily: 'SF Pro Rounded',
                                    fontSize: 30,
                                    letterSpacing:
                                        0 /*percentages not used in flutter. defaulting to zero*/,
                                    fontWeight: FontWeight.normal,
                                    height: 1),
                              )),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            // getWallet();
                            if (walletBalance >= totalCost) {
                              decreaseWallet();
                              addToTransaction();
                              deleteCollection();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          user_payment_successful(
                                              totalPayment: totalCost)));
                            } else {
                              showAlertDialog(context);
                            }
                            //if balance not sufficient => showAlertDialog(context)
                          },
                          child: Container(
                              margin: EdgeInsets.only(left: 100, top: 22),
                              height: 53,
                              width: 168,
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
                                'Confirm',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontFamily: 'SF Pro Rounded',
                                    fontSize: 18,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.normal,
                                    height: 1),
                              )),
                        ),
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ]),
    );
  }

  Future<void> decreaseWallet() {
    CollectionReference updateWallet =
        FirebaseFirestore.instance.collection('users');
    String? uid = FirebaseAuth.instance.currentUser?.uid;

    return updateWallet
        .doc(uid)
        .update({'wallet': FieldValue.increment(totalCost * -1)});
  }

  getWallet() {
    CollectionReference keyCollection =
        FirebaseFirestore.instance.collection('users');

    var wallets = keyCollection
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((DocumentSnapshot datas) {
      try {
        setState(() {
          walletBalance = datas.get(FieldPath(["wallet"]));
          print(datas.get(FieldPath(["wallet"])));
        });
      } catch (e) {}
    });
    // return walletBalance;
  }

  void deleteCollection() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('basket')
        .get()
        .then((snaps) {
      for (DocumentSnapshot ds in snaps.docs) {
        ds.reference.delete();
      }
    });
  }

  // Future<void> deleteItem(product_id) {
  //   CollectionReference selectitem = FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser?.uid)
  //       .collection('basket');
  //   return selectitem.();
  // }

  Future getBasket() async {
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('basket')
        .get();

    setState(() {
      thebooking =
          List.from(data.docs.map((doc) => BasketDataModel.fromSnapshot(doc)));
      for (var i = 0; i < thebooking.length; i++) {
        totalCost += int.parse(thebooking[i].product_price.toString()) *
            int.parse(thebooking[i].product_count.toString()) *
            int.parse(calcTime(thebooking[i].product_startDateTime,
                    thebooking[i].product_endDateTime)
                .toString());
      }

      // storeData = newstores;
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

  Future<void> addToTransaction() async {
    var userTransaction =
        await FirebaseFirestore.instance.collection('transactions').get();
    var count = userTransaction.docs.length + 1;
    var transactions = FirebaseFirestore.instance.collection('transactions');
    for (var eachDoc in thebooking) {
      transactions.doc(count.toString()).set({
        'Before_Image': "",
        'After_Image': "",
        'collectDate': eachDoc.product_startDateTime,
        'CollectedTime': Timestamp.now(),
        'ReturnedTime': Timestamp.now(),
        'collectDate': eachDoc.product_startDateTime,
        'collectTime': eachDoc.product_startDateTime,
        'displayPicture': eachDoc.product_displayPicture,
        'imgCapture': 'yes',
        'itemLoc': eachDoc.storeName,
        'itemId': eachDoc.product_id,
        'storeId': eachDoc.storeId,
        'name': eachDoc.product_name,
        'price': int.parse(eachDoc.product_price),
        'qty': int.parse(eachDoc.product_count),
        'returnDate': eachDoc.product_endDateTime,
        'returnTime': eachDoc.product_endDateTime,
        'returned': 'yes',
        'user': FirebaseAuth.instance.currentUser!.email.toString(),
        'ticketNumber': count,
        'status': "confirmed",
        'box_id': eachDoc.product_box_id,
        'box_number': eachDoc.product_box_number,
      });
      count++;
    }
  }
}

Widget _historyCard(
    {required BuildContext context,
    required String itemName,
    required int qty,
    required int pricePerhour,
    required Timestamp collectDate,
    required Timestamp returnDate,
    required Timestamp collectTime,
    required Timestamp returnTime,
    // required int ticketNumber,
    required String displayPicture}) {
  final TextStyle subtitleStyles = TextStyle(
    fontFamily: 'SF_Pro_Rounded',
    fontSize: 15,
    fontWeight: FontWeight.w300,
    color: Color(0xFF001D4A),
    wordSpacing: 1,
  );

  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: GestureDetector(
      onTap: () {},
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
                flex: 6,
                child: ListTile(
                  leading: Image.network(
                    displayPicture,
                    height: 48,
                    width: 48,
                  ),
                  title: Text(
                    itemName,
                    style: TextStyle(
                      fontFamily: 'SF_Pro_Rounded',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF001D4A),
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\$$pricePerhour /hour', style: subtitleStyles),
                      Row(
                        children: [
                          Container(
                            height: 17,
                            width: 80,
                            child: Text(
                              'Date: ',
                              style: TextStyle(
                                fontFamily: 'SF_Pro_Rounded',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF001D4A),
                              ),
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 17,
                                width: 135,
                                decoration: BoxDecoration(
                                    color: Color(0xFFDBE4EE),
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 17,
                                width: 135,
                                child: Center(
                                  child: Text(
                                    '${DateFormat('dd/MM/yyyy').format(collectDate.toDate())} - ${DateFormat('dd/MM/yyyy').format(returnDate.toDate())}',
                                    style: TextStyle(
                                      fontFamily: 'SF_Pro_Rounded',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF001D4A),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 5,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 17,
                            width: 80,
                            child: Text(
                              'Start Time: ',
                              style: TextStyle(
                                fontFamily: 'SF_Pro_Rounded',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF001D4A),
                              ),
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 17,
                                width: 135,
                                decoration: BoxDecoration(
                                    color: Color(0xFFDBE4EE),
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 17,
                                width: 135,
                                child: Center(
                                  child: Text(
                                    '${DateFormat('kk:mm:ss').format(collectTime.toDate())}',
                                    style: TextStyle(
                                      fontFamily: 'SF_Pro_Rounded',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF001D4A),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 5,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 17,
                            width: 80,
                            child: Text(
                              'End Time: ',
                              style: TextStyle(
                                fontFamily: 'SF_Pro_Rounded',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF001D4A),
                              ),
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 17,
                                width: 135,
                                decoration: BoxDecoration(
                                    color: Color(0xFFDBE4EE),
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 17,
                                width: 135,
                                child: Center(
                                  child: Text(
                                    '${DateFormat('kk:mm:ss').format(returnTime.toDate())}',
                                    style: TextStyle(
                                      fontFamily: 'SF_Pro_Rounded',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF001D4A),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 5,
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 17,
                            width: 80,
                            child: Text(
                              'Quantity: ',
                              style: TextStyle(
                                fontFamily: 'SF_Pro_Rounded',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF001D4A),
                              ),
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                height: 17,
                                width: 135,
                                decoration: BoxDecoration(
                                    color: Color(0xFFDBE4EE),
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 17,
                                width: 135,
                                child: Center(
                                  child: Text(
                                    '$qty',
                                    style: TextStyle(
                                      fontFamily: 'SF_Pro_Rounded',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF001D4A),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

showAlertDialog(BuildContext context) {
  // set up the buttons
  shape:
  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0));
  color:
  Color(0xFFDBE4EE);
  Widget okButton = ElevatedButton(
    style: ElevatedButton.styleFrom(
        primary: const Color(0xFF001D4A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(38))),
    child: Text(
      "OK",
      style: TextStyle(
          color: Color(0xFFFBFBFF),
          fontFamily: 'SF_Pro_Rounded',
          fontSize: 18,
          fontWeight: FontWeight.w700),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    backgroundColor: Color(0xFFDBE4EE),
    title: Text("Insufficient Balance", textAlign: TextAlign.center),
    content: Text("Please top-up your wallet to make this booking.",
        textAlign: TextAlign.center),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 30, width: 100, child: okButton),
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
//       storeId = "",
//       storeName = "";

//   Timestamp product_startDateTime = Timestamp.now(),
//       product_endDateTime = Timestamp.now();
//   // ticket_number = "";

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
//         'storeId': storeId,
//         'storeName': storeName
//         // 'ticket_number': ticket_number,
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
//         product_startDateTime = snapshot.data()['startDateTime'],
//         product_endDateTime = snapshot.data()['endDateTime'],
//         storeName = snapshot.data()['storeName'],
//         storeId = snapshot.data()['storeId'];

//   // ticket_number = snapshot.data()['ticket_number'].toString();

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
        'product_startDateTime': product_startDateTime.toString(),
        'product_endDateTime': product_endDateTime.toString(),
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
