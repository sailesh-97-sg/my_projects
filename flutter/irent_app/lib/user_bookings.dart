import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:irent_app/collect_barcode.dart';
// import 'package:irent_app/constants.dart';

import 'app_icons.dart';
import 'bookings_details.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class user_bookings extends StatefulWidget {
  const user_bookings({Key? key}) : super(key: key);

  @override
  State<user_bookings> createState() => _user_bookingsState();
}

class _user_bookingsState extends State<user_bookings> {
  final Color white = const Color(0xFFFBFBFF);
  final Color oxford = const Color(0xFF001D4A);
  final Color aliceblue = const Color(0xFF81A4CD);
  final Color iceberg = const Color(0xFFDBE4EE);
  final Color marigold = const Color(0xFFECA400);
  final Color transparent = const Color(0x4DE3E3E3);
  // List bookings = [];
  List ongoingBookings = [];
  List confirmedBookings = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getBookingConfirmed();
    getBookingOnGoing();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: white,
        body: Column(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
            child: Text(
              'Confirmed Bookings',
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
                  itemCount: confirmedBookings.length,
                  itemBuilder: (context, index) {
                    // for (var product in bookingsData) {
                    return _bookingsCard(
                        context: context,
                        index: index,
                        name: confirmedBookings[index].name,
                        qty: confirmedBookings[index].qty,
                        price: confirmedBookings[index].price,
                        collectDate: confirmedBookings[index].collectDate,
                        returnDate: confirmedBookings[index].returnDate,
                        collectTime: confirmedBookings[index].collectTime,
                        returnTime: confirmedBookings[index].returnTime,
                        ticketNumber: confirmedBookings[index].ticketNumber,
                        displayPicture: confirmedBookings[index].displayPicture,
                        store_id: confirmedBookings[index].storeId,
                        box_id: confirmedBookings[index].box_id);
                    // }
                    // throw 'No Data Found';
                  }),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
            child: Text(
              'Ongoing Bookings',
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
                  itemCount: ongoingBookings.length,
                  itemBuilder: (context, index) {
                    // for (var product in bookingsData) {
                    return _bookingsOngoingCard(
                        context: context,
                        index: index,
                        name: ongoingBookings[index].name,
                        qty: ongoingBookings[index].qty,
                        price: ongoingBookings[index].price,
                        collectDate: ongoingBookings[index].collectDate,
                        returnDate: ongoingBookings[index].returnDate,
                        collectTime: ongoingBookings[index].collectTime,
                        returnTime: ongoingBookings[index].returnTime,
                        ticketNumber: ongoingBookings[index].ticketNumber,
                        displayPicture: ongoingBookings[index].displayPicture);
                    // }
                    // throw 'No Data Found';
                  }),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _bookingsCard(
      {required BuildContext context,
      required int index,
      required String name,
      required int qty,
      required int price,
      required Timestamp collectDate,
      required Timestamp returnDate,
      required Timestamp collectTime,
      required Timestamp returnTime,
      required int ticketNumber,
      required String displayPicture,
      required String store_id,
      required String box_id}) {
    final TextStyle subtitleStyles = TextStyle(
      fontFamily: 'SF_Pro_Rounded',
      fontSize: 15,
      fontWeight: FontWeight.w300,
      color: Color(0xFF001D4A),
      wordSpacing: 1,
    );

    return Column(
      children: [
        InkWell(
          child: Card(
            color: Color(0xFF81A4CD),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10, top: 5, bottom: 5),
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
                        name,
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
                              'Date: ${DateFormat('dd/MM/yyyy').format(collectDate.toDate())} - ${DateFormat('dd/MM/yyyy').format(returnDate.toDate())}',
                              style: subtitleStyles),
                          Text(
                              'Collection Time: ${DateFormat('kk:mm:ss').format(collectTime.toDate())}',
                              style: subtitleStyles),
                          Text(
                              'Return Time: ${DateFormat('kk:mm:ss').format(returnTime.toDate())}',
                              style: subtitleStyles),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Text('#$ticketNumber', style: subtitleStyles),
                        SizedBox(
                          height: 25,
                        ),
                        Icon(AppIcons.arrowforward, size: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => collect_barcode(
                        ticketNumber: ticketNumber.toString(),
                        store_id: store_id,
                        box_id:
                            box_id))); //time for collection => collect_barcode()
          },
        ),
      ],
    );
  }

  Widget _bookingsOngoingCard(
      {required BuildContext context,
      required int index,
      required String name,
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

    return Column(
      children: [
        InkWell(
          child: Card(
            color: Color(0xFF81A4CD),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10, top: 5, bottom: 5),
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
                        name,
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
                              'Date: ${DateFormat('dd/MM/yyyy').format(collectDate.toDate())} - ${DateFormat('dd/MM/yyyy').format(returnDate.toDate())}',
                              style: subtitleStyles),
                          Text(
                              'Collection Time: ${DateFormat('kk:mm:ss').format(collectTime.toDate())}',
                              style: subtitleStyles),
                          Text(
                              'Return Time: ${DateFormat('kk:mm:ss').format(returnTime.toDate())}',
                              style: subtitleStyles),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Text('#$ticketNumber', style: subtitleStyles),
                        SizedBox(
                          height: 25,
                        ),
                        Icon(AppIcons.arrowforward, size: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => bookings_details(
                      bookingsDataModel: ongoingBookings[index]),
                ));
          },
        ),
      ],
    );
  }

  getBookingConfirmed() {
    FirebaseFirestore.instance
        .collection('transactions')
        .where("user", isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .where("status", isEqualTo: "confirmed")
        .snapshots()
        .listen((data) {
      setState(() {
        confirmedBookings = List.from(
            data.docs.map((doc) => BookingsDataModel.fromSnapshot(doc)));
        // storeData = newstores;
      });
    });
  }

  getBookingOnGoing() {
    FirebaseFirestore.instance
        .collection('transactions')
        .where("user", isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .where("status", isEqualTo: "ongoing")
        .snapshots()
        .listen((data) {
      setState(() {
        ongoingBookings = List.from(
            data.docs.map((doc) => BookingsDataModel.fromSnapshot(doc)));
        // storeData = newstores;
      });
    });
  }
}

class BookingsDataModel {
  String name = "", displayPicture = "", box_id = "", storeId = "";
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
        "box_id": box_id,
        "storeId": storeId,
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
        displayPicture = snapshot.data()['displayPicture'],
        box_id = snapshot.data()['box_id'],
        storeId = snapshot.data()['storeId'];
}
