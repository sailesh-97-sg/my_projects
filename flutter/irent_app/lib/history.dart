// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'history_details.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Color white = const Color(0xFFFBFBFF);
  final Color oxford = const Color(0xFF001D4A);
  final Color aliceblue = const Color(0xFF81A4CD);
  final Color iceberg = const Color(0xFFDBE4EE);
  final Color marigold = const Color(0xFFECA400);
  final Color transparent = const Color(0x4DE3E3E3);

  bool? _success;
  String? _userEmail;
  List historyData = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getBooking();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: white,
      body: Column(children: [
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
                color: aliceblue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                )),
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    'images/cross-bg-cropped-2.png',
                  ),
                ),
                Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    centerTitle: true,
                    title: Text(
                      'History',
                      style: TextStyle(
                          color: oxford,
                          fontFamily: 'SF_Pro_Rounded',
                          fontSize: 25,
                          fontWeight: FontWeight.w500),
                    ),
                    elevation: 0,
                    leading: Row(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.close,
                            size: 32,
                            color: oxford,
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
        Expanded(
          flex: 6,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: ListView.builder(
                itemCount: historyData.length,
                itemBuilder: (context, index) {
                  // for (var product in historyData) {
                  return _historyCard(
                      context: context,
                      index: index,
                      itemName: historyData[index].name,
                      qty: historyData[index].qty,
                      price: historyData[index].price,
                      collectDate: historyData[index].collectDate,
                      returnDate: historyData[index].returnDate,
                      collectTime: historyData[index].collectTime,
                      returnTime: historyData[index].returnTime,
                      ticketNumber: historyData[index].ticketNumber,
                      displayPicture: historyData[index].displayPicture);
                  // }
                  // throw 'No Data Found';
                }),
          ),
        ),
      ]),
    );
  }

  Widget _historyCard(
      {required BuildContext context,
      required int index,
      required String itemName,
      required int qty,
      required int price,
      required Timestamp collectDate,
      required Timestamp returnDate,
      required Timestamp collectTime,
      required Timestamp returnTime,
      required int ticketNumber,
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
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HistoryDetailsPage(historyData: historyData[index])),
          );
        },
        child: Card(
          color: Color(0xFFDBE4EE),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10, top: 15, bottom: 15),
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
                        Text('Qty: $qty   |   Price: \$$price',
                            style: subtitleStyles),
                        Text(
                            'Date: ${DateTime.fromMillisecondsSinceEpoch(collectDate.millisecondsSinceEpoch)} - ${DateTime.fromMillisecondsSinceEpoch(returnDate.millisecondsSinceEpoch)}',
                            style: subtitleStyles),
                        //Text('Collection Time: ${DateTime.fromMillisecondsSinceEpoch(collectDate.millisecondsSinceEpoch)}',
                        //    style: subtitleStyles),
                        //Text('Return Time: $returnTime', style: subtitleStyles),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text('#$ticketNumber', style: subtitleStyles),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getBooking() {
    FirebaseFirestore.instance
        .collection('transactions')
        .where("user", isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .where("status", isEqualTo: "completed")
        .snapshots()
        .listen((data) {
      setState(() {
        historyData = List.from(
            data.docs.map((doc) => BookingsDataModel.fromSnapshot(doc)));
        // storeData = newstores;
      });
    });
  }
}

class BookingsDataModel {
  String name = "", displayPicture = "", status = "";
  int qty = 0, price = 0, ticketNumber = 0;
  Timestamp collectDate = Timestamp.now(),
      returnDate = Timestamp.now(),
      collectTime = Timestamp.now(),
      returnTime = Timestamp.now();
  BookingsDataModel();
  Map<String, dynamic> toJson() => {
        "name": name,
        "qty": qty,
        "price": price,
        "collectDate": collectDate,
        "returnDate": returnDate,
        "collectTime": collectTime,
        "returnTime": returnTime,
        "ticketNumber": ticketNumber,
        "displayPicture": displayPicture,
        "status": status,
      };
  BookingsDataModel.fromSnapshot(snapshot)
      : name = snapshot.data()['name'],
        qty = snapshot.data()['qty'],
        price = snapshot.data()['price'],
        collectDate = snapshot.data()['collectDate'],
        returnDate = snapshot.data()['returnDate'],
        collectTime = snapshot.data()['collectTime'],
        returnTime = snapshot.data()['returnTime'],
        ticketNumber = snapshot.data()['ticketNumber'],
        status = snapshot.data()['status'],
        displayPicture = snapshot.data()['displayPicture'];
}
