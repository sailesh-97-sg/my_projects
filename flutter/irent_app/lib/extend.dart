import 'dart:async';
import 'bookings_details.dart';
import 'package:flutter/material.dart';
import 'package:irent_app/extend_payment.dart';
import 'user_bookings.dart';

class extend extends StatefulWidget {
  final Color white = const Color(0xFFFBFBFF);
  final Color oxford = const Color(0xFF001D4A);
  final Color aliceblue = const Color(0xFF81A4CD);
  final Color iceberg = const Color(0xFFDBE4EE);
  final Color marigold = const Color(0xFFECA400);
  final Color transparent = const Color(0x4DE3E3E3);

  const extend({Key? key}) : super(key: key);

  @override
  State<extend> createState() => _extendState();
}

class _extendState extends State<extend> {
  DateTime dateTime1 = DateTime(2022);
  DateTime dateTime2 = DateTime(2022);
  TimeOfDay _time = TimeOfDay.now();
  String initialValue1 = '12 AM';
  String initialValue2 = '12 AM';

  var itemList = [
    '12 AM',
    '1 AM',
    '2 AM',
    '3 AM',
    '4 AM',
    '5 AM',
    '6 AM',
    '7 AM',
    '8 AM',
    '9 AM',
    '10 AM',
    '11 AM',
    '12 PM',
    '1 PM',
    '2 PM',
    '3 PM',
    '4 PM',
    '5 PM',
    '6 PM',
    '7 PM',
    '8 PM',
    '9 PM',
    '10 PM',
    '11 PM',
  ];

  int _count = 1;

  void _increamentCount() {
    setState(() {
      _count++;
    });
  }

  void _decreamentCount() {
    setState(() {
      _count--;
    });
  }

  @override
  void initState() {
    super.initState();

    // simply use this
    Timer.run(() {
      showAlertDialog(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var bookingsDataModel;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFFBFBFF),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Extend',
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
          SizedBox(height: 20),
          Row(
            children: [
              Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 26, top: 20),
                      height: 20,
                      width: 180,
                      child: Text(
                        'Old Date',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromRGBO(0, 29, 74, 1),
                            fontFamily: 'SF Pro Rounded',
                            fontSize: 16,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      )),
                  Container(
                    height: 40,
                    width: 160,
                    child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: dateTime1,
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2300));
                            if (newDate != null) {
                              setState(() {
                                dateTime1 = newDate;
                              });
                            }
                          },
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Color.fromRGBO(0, 29, 74, 1),
                          ),
                          label: Text(
                              '${dateTime1.day}/${dateTime1.month}/${dateTime1.year}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 29, 74, 1),
                                  fontFamily: 'SF Pro Rounded',
                                  fontSize: 16,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal)),
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(158, 41),
                            primary: Color.fromRGBO(219, 228, 238, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        )),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 5, top: 20),
                      height: 19,
                      width: 175,
                      child: Text(
                        'New Date',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromRGBO(0, 29, 74, 1),
                            fontFamily: 'SF Pro Rounded',
                            fontSize: 16,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      )),
                  Container(
                    height: 40,
                    width: 160,
                    child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: dateTime2,
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2300));
                            if (newDate != null) {
                              setState(() {
                                dateTime2 = newDate;
                              });
                            }
                          },
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Color.fromRGBO(0, 29, 74, 1),
                          ),
                          label: Text(
                              '${dateTime2.day}/${dateTime2.month}/${dateTime2.year}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 29, 74, 1),
                                  fontFamily: 'SF Pro Rounded',
                                  fontSize: 16,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal)),
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(158, 41),
                            primary: Color.fromRGBO(219, 228, 238, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 26, top: 20),
                      height: 20,
                      width: 180,
                      child: Text(
                        'Old Time',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromRGBO(0, 29, 74, 1),
                            fontFamily: 'SF Pro Rounded',
                            fontSize: 16,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      )),
                  Container(
                    height: 40,
                    width: 160,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(219, 228, 238, 1),
                        fixedSize: const Size(158, 41),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {},
                      child: Container(
                        child: DropdownButton(
                          style: TextStyle(
                              color: Color.fromRGBO(0, 29, 74, 1),
                              fontSize: 16),
                          dropdownColor: Color.fromRGBO(219, 228, 238, 1),
                          icon: Icon(Icons.keyboard_arrow_down,
                              color: Color.fromRGBO(0, 29, 74, 1)),
                          underline: Container(),
                          value: initialValue1,
                          onChanged: (value1) {
                            setState(() {
                              initialValue1 = value1.toString();
                            });
                          },
                          menuMaxHeight: 150,
                          focusNode: FocusNode(),
                          isExpanded: true,
                          items: itemList.map((itemone) {
                            return DropdownMenuItem(
                                value: itemone, child: Text(itemone));
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 5, top: 20),
                      height: 19,
                      width: 175,
                      child: Text(
                        'New Time',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromRGBO(0, 29, 74, 1),
                            fontFamily: 'SF Pro Rounded',
                            fontSize: 16,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      )),
                  Container(
                    height: 40,
                    width: 160,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(219, 228, 238, 1),
                        fixedSize: const Size(158, 41),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {},
                      child: Container(
                        child: DropdownButton(
                          style: TextStyle(
                              color: Color.fromRGBO(0, 29, 74, 1),
                              fontSize: 16),
                          dropdownColor: Color.fromRGBO(219, 228, 238, 1),
                          icon: Icon(Icons.keyboard_arrow_down,
                              color: Color.fromRGBO(0, 29, 74, 1)),
                          underline: Container(),
                          value: initialValue2,
                          onChanged: (value2) {
                            setState(() {
                              initialValue2 = value2.toString();
                            });
                          },
                          menuMaxHeight: 150,
                          focusNode: FocusNode(),
                          isExpanded: true,
                          items: itemList.map((item_end) {
                            return DropdownMenuItem(
                                value: item_end, child: Text(item_end));
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Container(
                  height: 22,
                  width: 67,
                  margin: EdgeInsets.only(left: 26, top: 10),
                  child: Text(
                    'Quantity',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 29, 74, 1),
                        fontFamily: 'SF Pro Rounded',
                        fontSize: 16,
                        letterSpacing: 0,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  )),
            ],
          ),
          Container(
            width: 126,
            height: 40,
            margin: EdgeInsets.only(left: 250),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                    heroTag: "btn1",
                    backgroundColor: Color.fromRGBO(219, 228, 238, 1),
                    child: Icon(Icons.add, color: Color.fromRGBO(0, 29, 74, 1)),
                    onPressed: _increamentCount),
                Text('${_count}'),
                FloatingActionButton(
                  heroTag: "btn2",
                  backgroundColor: Color.fromRGBO(219, 228, 238, 1),
                  child:
                      Icon(Icons.remove, color: Color.fromRGBO(0, 29, 74, 1)),
                  onPressed: _decreamentCount,
                )
              ],
            ),
          ),
        ]),
        bottomNavigationBar: Container(
          height: 100,
          color: const Color(0xFF001D4A),
          child: Column(children: [
            Container(
              child: Row(children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                          padding: EdgeInsets.only(left: 30, top: 20),
                          child: Text(
                            'Total',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color.fromRGBO(251, 251, 255, 1),
                              fontFamily: 'SF Pro Rounded',
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          )),
                      Container(
                          padding: EdgeInsets.only(left: 30),
                          child: Text(
                            '\$2',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color.fromRGBO(251, 251, 255, 1),
                              fontFamily: 'SF Pro Rounded',
                              fontSize: 30,
                              fontWeight: FontWeight.normal,
                            ),
                          )),
                    ],
                  ),
                ),
                Column(
                  children: [
                    InkWell(
                      child: Container(
                          margin: EdgeInsets.only(left: 140, top: 20),
                          height: 53,
                          width: 168,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
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
                              fontWeight: FontWeight.normal,
                            ),
                          )),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => extend_payment())));
                      },
                    ),
                  ],
                ),
              ]),
            )
          ]),
        ));
  }
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
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Attention!",
          style: TextStyle(
            fontFamily: 'SF Pro Rounded',
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
    content: Text(
        "1.Extension is subject to availability. \n2.Maximum period of extension is 2\n   hours."),
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
