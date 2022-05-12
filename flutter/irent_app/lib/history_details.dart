// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:irent_app/app_icons.dart';
import 'package:irent_app/switch_nav.dart';
import 'history.dart';
import 'homepage.dart';
// import 'constants.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class HistoryDetailsPage extends StatefulWidget {
  final BookingsDataModel historyData;
  const HistoryDetailsPage({Key? key, required this.historyData})
      : super(key: key);

  @override
  State<HistoryDetailsPage> createState() => _HistoryDetailsPageState();
}

class _HistoryDetailsPageState extends State<HistoryDetailsPage> {
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
          child: Column(children: [
            Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 30, top: 30),
                child: _historyDetails(
                    itemName: widget.historyData.name,
                    qty: widget.historyData.qty,
                    price: widget.historyData.price,
                    status: widget.historyData.status,
                    returned: widget.historyData.status,
                    ticketNumber: widget.historyData.ticketNumber,
                    displayPicture: widget.historyData.displayPicture)),
            _fees(),
          ]),
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

Widget _historyDetails(
    {required String itemName,
    required int qty,
    required int price,
    required String status,
    required String returned,
    required int ticketNumber,
    required String displayPicture}) {
  return Column(
    children: [
      Row(
        children: [
          Expanded(flex: 1, child: Image.network(displayPicture)),
          Expanded(
            flex: 3,
            child: Text(
              itemName,
              style: TextStyle(
                fontFamily: 'SF_Pro_Rounded',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF001D4A),
                wordSpacing: 1,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      _fields(
          title: 'Booking Reference',
          subtitle: '#$ticketNumber',
          width: double.infinity),
      Row(
        children: [
          Expanded(
            flex: 1,
            child: _fields(
                title: 'Collected at',
                subtitle: status,
                width: double.infinity),
          ),
          Expanded(
            flex: 1,
            child: _fields(
                title: 'Return at', subtitle: returned, width: double.infinity),
          ),
        ],
      )
    ],
  );
}

Widget _fees() {
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
    padding: const EdgeInsets.only(left: 30, top: 30),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Fees', style: titleStyles),
      Divider(
        height: 15,
        thickness: 1,
        endIndent: 25,
        color: dividerColor,
      ),
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Expanded(
                    flex: 3, child: Text('Rental Fee', style: subtitleStyles)),
                Expanded(flex: 1, child: Text('\$5', style: subtitleStyles)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Text('Extension Fee', style: subtitleStyles)),
                Expanded(flex: 1, child: Text('\$2', style: subtitleStyles)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Expanded(
                    flex: 3, child: Text('Late Fee', style: subtitleStyles)),
                Expanded(flex: 1, child: Text('\$5.25', style: subtitleStyles)),
              ],
            ),
          ),
          Divider(
            height: 15,
            thickness: 1,
            endIndent: 25,
            color: dividerColor,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Expanded(flex: 3, child: Text('Total', style: titleStyles)),
                Expanded(flex: 1, child: Text('\$12.25', style: titleStyles)),
              ],
            ),
          ),
        ],
      )
    ]),
  );
}
