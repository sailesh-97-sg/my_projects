// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'admin_bookings.dart';

class BookingDetailsPage extends StatelessWidget {
  final Color white = const Color(0xFFFBFBFF);
  final Color oxford = const Color(0xFF001D4A);
  final Color aliceblue = const Color(0xFF81A4CD);
  final Color iceberg = const Color(0xFFDBE4EE);
  final Color marigold = const Color(0xFFECA400);
  final Color transparent = const Color(0x4DE3E3E3);

  final BookingsDataModel bookingsDataModel;
  const BookingDetailsPage({Key? key, required this.bookingsDataModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      'Receipts',
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
            child: SingleChildScrollView(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 30),
                  child: _bookingsDetails(
                    user: bookingsDataModel.user,
                    itemName: bookingsDataModel.name,
                    qty: int.parse(bookingsDataModel.qty),
                    price: num.parse(bookingsDataModel.price),
                    collectDate: bookingsDataModel.collectDate,
                    returnDate: bookingsDataModel.returnDate,
                    collectTime: bookingsDataModel.collectTime,
                    returnTime: bookingsDataModel.returnTime,
                    ticketNumber: int.parse(bookingsDataModel.ticketNumber),
                    displayPicture: bookingsDataModel.displayPicture,
                    itemLoc: bookingsDataModel.itemLoc,
                    returned: bookingsDataModel.returned,
                    imgCapture: bookingsDataModel.imgCapture,
                  )),
            )),
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

Widget _bookingsDetails(
    {required String user,
    required String itemName,
    required int qty,
    required num price,
    required String collectDate,
    required String returnDate,
    required String collectTime,
    required String returnTime,
    required int ticketNumber,
    required String displayPicture,
    required String itemLoc,
    required String returned,
    required String imgCapture}) {
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
          Expanded(flex: 1, child: Image.asset(displayPicture)),
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
                subtitle: '#$ticketNumber',
                width: double.infinity),
          ),
          Expanded(
            flex: 1,
            child:
                _fields(title: 'User', subtitle: user, width: double.infinity),
          ),
        ],
      ),
      Row(
        children: [
          Expanded(
            flex: 1,
            child: _fields(
                title: 'Collected at',
                subtitle: '$collectDate, $collectTime',
                width: double.infinity),
          ),
          Expanded(
            flex: 1,
            child: _fields(
                title: 'Return at',
                subtitle: '$returnDate, $returnTime',
                width: double.infinity),
          ),
        ],
      ),
      Row(
        children: [
          Expanded(
            flex: 1,
            child: _fields(
                title: 'Item Location',
                subtitle: itemLoc,
                width: double.infinity),
          ),
          Expanded(
            flex: 1,
            child: _fields(
                title: 'Returned', subtitle: returned, width: double.infinity),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Last Captured Image', style: titleStyles),
            Divider(
              height: 15,
              thickness: 1,
              endIndent: 25,
              color: dividerColor,
            ),
            Center(child: Image.asset(imgCapture, height: 200, width: 200)),
          ],
        ),
      ),
    ],
  );
}
