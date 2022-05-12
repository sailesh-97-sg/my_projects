import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'constants.dart';
import 'extend.dart';
import 'return_barcode.dart';
import 'user_bookings.dart';

class bookings_details extends StatelessWidget {
  final Color white = const Color(0xFFFBFBFF);
  final Color oxford = const Color(0xFF001D4A);
  final Color aliceblue = const Color(0xFF81A4CD);
  final Color iceberg = const Color(0xFFDBE4EE);
  final Color marigold = const Color(0xFFECA400);
  final Color transparent = const Color(0x4DE3E3E3);

  final BookingsDataModel bookingsDataModel;
  bookings_details({Key? key, required this.bookingsDataModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Booking Details',
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
        Divider(
          color: Colors.black,
        ),
        Expanded(
            flex: 6,
            child: SingleChildScrollView(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 30),
                  child: _bookingsDetails(
                    itemName: bookingsDataModel.name,
                    qty: bookingsDataModel.qty,
                    price: bookingsDataModel.price,
                    collectDate: bookingsDataModel.collectDate,
                    returnDate: bookingsDataModel.returnDate,
                    collectTime: bookingsDataModel.collectTime,
                    returnTime: bookingsDataModel.returnTime,
                    ticketNumber: bookingsDataModel.ticketNumber,
                    displayPicture: bookingsDataModel.displayPicture,
                  )),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                padding: EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  width: 140,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => extend()));
                    },
                    child: Text(
                      'Extend',
                      style: TextStyle(
                          color: white,
                          fontFamily: 'SF_Pro_Rounded',
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFF001D4A),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(38))),
                  ),
                )),
            Container(
                padding: EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  width: 140,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => return_barcode(
                                  ticketNumber:
                                      bookingsDataModel.ticketNumber.toString(),
                                  store_id: bookingsDataModel.storeId,
                                  box_id: bookingsDataModel
                                      .box_id))); //if return succeess --> return_success()
                    },
                    child: Text(
                      'Return',
                      style: TextStyle(
                          color: white,
                          fontFamily: 'SF_Pro_Rounded',
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xFFECA400),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(38))),
                  ),
                ))
          ],
        )
      ]),
    );
  }
}

Widget _fields({
  required String title,
  required String subtitle,
  required double width,
}) {
  final TextStyle titleStyles = TextStyle(
    fontFamily: 'SF_Pro_Rounded',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Color(0xFF001D4A),
    wordSpacing: 1,
  );
  final TextStyle subtitleStyles = TextStyle(
    fontFamily: 'SF_Pro_Rounded',
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: Color(0xFF001D4A),
    wordSpacing: 1,
  );
  final Color dividerColor = Color(0x8081A4CD);

  return Padding(
    padding: const EdgeInsets.only(top: 30.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: titleStyles),
        Divider(
          height: 15,
          thickness: 1,
          endIndent: 25,
          color: dividerColor,
        ),
        Text(subtitle, style: subtitleStyles),
      ],
    ),
  );
}

Widget _bookingsDetails({
  required String itemName,
  required int qty,
  required int price,
  required Timestamp collectDate,
  required Timestamp returnDate,
  required Timestamp collectTime,
  required Timestamp returnTime,
  required int ticketNumber,
  required String displayPicture,
}) {
  final TextStyle titleStyles = TextStyle(
    fontFamily: 'SF_Pro_Rounded',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Color(0xFF001D4A),
    wordSpacing: 1,
  );
  final Color dividerColor = Color(0x8081A4CD);
  return Column(
    children: [
      SizedBox(
        height: 30,
      ),
      Row(
        children: [
          Expanded(flex: 1, child: Image.network(displayPicture)),
          SizedBox(width: 20),
          Expanded(
            flex: 2,
            child: Text(
              itemName,
              style: TextStyle(
                fontFamily: 'SF_Pro_Rounded',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF001D4A),
                wordSpacing: 1,
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
      Row(
        children: [
          Expanded(
            flex: 1,
            child: _fields(
                title: 'Booking Reference',
                subtitle: '#$ticketNumber  ',
                width: double.infinity),
          ),
        ],
      ),
      Row(
        children: [
          Expanded(
            flex: 1,
            child: _fields(
                title: 'Pickup',
                subtitle:
                    '${DateFormat('dd/MM/yyyy').format(collectDate.toDate())} - ${DateFormat('kk:mm:ss').format(collectTime.toDate())}',
                width: double.infinity),
          ),
          Expanded(
            flex: 1,
            child: _fields(
                title: 'Return',
                subtitle:
                    '${DateFormat('dd/MM/yyyy').format(returnDate.toDate())} - ${DateFormat('kk:mm:ss').format(returnTime.toDate())}',
                width: double.infinity),
          ),
        ],
      ),
      Row(
        children: [
          Expanded(
            flex: 1,
            child: _fields(
                title: 'Extension (hrs)',
                subtitle: '- ',
                width: double.infinity),
          ),
          Expanded(flex: 1, child: Container(width: 40)),
        ],
      ),
      Row(
        children: [
          Expanded(
            flex: 1,
            child: _fields(
                title: 'Fees',
                subtitle:
                    'Rental Fee                                  \$$price \n\nExtension Fees                           \$$price\n\nLate Fees                                   \$$price ',
                width: double.infinity),
          ),
        ],
      ),
      Row(
        children: [
          Expanded(
            flex: 1,
            child:
                _fields(title: 'Total', subtitle: '', width: double.infinity),
          ),
        ],
      ),
    ],
  );
}
