// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:irent_app/account.dart';
import 'package:irent_app/constants.dart';
import 'package:irent_app/qrrtest.dart';
import 'dart:ui';
import 'app_icons.dart';
import 'datetimetest.dart';
import 'package:irent_app/app_icons.dart';
import 'package:irent_app/user_home.dart';
import 'package:irent_app/user_bookings.dart';
import 'package:irent_app/basket.dart';
import 'account.dart';
import 'qrrtest.dart';
import 'package:intl/intl.dart';
import 'user_bookings.dart';

class SwitchNavBar extends StatefulWidget {
  const SwitchNavBar({Key? key}) : super(key: key);

  @override
  State<SwitchNavBar> createState() => _SwitchNavBarState();
}

class _SwitchNavBarState extends State<SwitchNavBar> {
  int _selectedIndex = 0;
  final Color iceberg = const Color(0xFFDBE4EE);
  static const TextStyle titleStyle = TextStyle(
      fontSize: 25, color: Color(0xFF001D4A), fontWeight: FontWeight.w500);
  final TextStyle notifTitleStyle = TextStyle(
    fontFamily: 'SF_Pro_Rounded',
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Color(0xFF001D4A),
  );
  static const List<Widget> _titleBar = <Widget>[
    Text(
      'iRent',
      style: titleStyle,
    ),
    Text(
      'Bookings',
      style: titleStyle,
    ),
    Text(
      'Basket',
      style: titleStyle,
    ),
    Text(
      'Account',
      style: titleStyle,
    ),
  ];
  final List<Widget> _bodyContents = <Widget>[
    user_home(),
    user_bookings(),
    basket(),
    AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFBFBFF),
        centerTitle: true,
        title: _titleBar.elementAt(_selectedIndex),
        elevation: 0,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        alignment: Alignment.topCenter,
                        backgroundColor: iceberg,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        elevation: 16,
                        child: Container(
                          child: ListView(
                            shrinkWrap: true,
                            children: <Widget>[
                              SizedBox(height: 20),
                              Center(
                                  child: Text(
                                'Notifications',
                                style: notifTitleStyle,
                              )),
                              for (var notif in notificationData)
                                _notifItem(
                                  notif['storeName'].toString(),
                                  notif['itemName'].toString(),
                                  notif['collectTime'].toString(),
                                  notif['returnTime'].toString(),
                                  int.parse(notif['ticketNumber'].toString()),
                                  notif['displayPicture'].toString(),
                                ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Icon(
                  AppIcons.notifications,
                  size: 32,
                  color: Color(0xFF001D4A),
                ),
              )),
        ],
      ),
      body: Center(
        child: _bodyContents.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: Color(0xFF001D4A)),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          // this will be set when a new tab is tapped
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  AppIcons.home,
                  size: 30,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(
                  AppIcons.bookings,
                  size: 30,
                ),
                label: "Bookings"),
            BottomNavigationBarItem(
                icon: Icon(
                  AppIcons.basket,
                  size: 30,
                ),
                label: "Basket"),
            BottomNavigationBarItem(
                icon: Icon(
                  AppIcons.account,
                  size: 30,
                ),
                label: "Account"),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color(0xFFECA400),
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Widget _notifItem(String storeName, String itemName, String collectTime,
      String returnTime, int ticket, String image) {
    final TextStyle storeStyle = TextStyle(
      fontFamily: 'SF_Pro_Rounded',
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: Color(0xFF001D4A),
    );
    final TextStyle itemStyle = TextStyle(
      fontFamily: 'SF_Pro_Rounded',
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Color(0xFF001D4A),
    );
    final TextStyle notifStyle = TextStyle(
      fontFamily: 'SF_Pro_Rounded',
      fontSize: 12,
      fontWeight: FontWeight.w300,
      color: Color(0xFF001D4A),
    );
    final Color oxford = const Color(0xFF001D4A);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 5),
          Divider(
            height: 15,
            thickness: 1,
            color: Color(0x66001D4A),
          ),
          SizedBox(height: 5),
          Row(
            children: <Widget>[
              Image.asset(
                image,
                width: 40,
                height: 40,
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(storeName, style: storeStyle),
                      SizedBox(
                        width: 15,
                        child: Center(child: Text('|', style: notifStyle)),
                      ),
                      Text('Order #$ticket', style: notifStyle),
                    ],
                  ),
                  Text(itemName, style: itemStyle),
                  Text(
                    _notifText(collectTime, returnTime),
                    style: notifStyle,
                  )
                ],
              ),
              Spacer(),
              Container(
                alignment: Alignment.topRight,
                child: Text(
                  _notifTime(collectTime, returnTime),
                  style: notifStyle,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _notifTime(String collectTime, String returnTime) {
    final int timeStamp =
        DateTime.parse(returnTime).difference(DateTime.parse(now)).inMinutes;

    return '$timeStamp m ago';
  }

  String _notifText(String collectTime, String returnTime) {
    final TextStyle notifStyle = TextStyle(
      fontFamily: 'SF_Pro_Rounded',
      fontSize: 12,
      fontWeight: FontWeight.w300,
      color: Color(0xFF001D4A),
    );

    final int timeToReturn =
        DateTime.parse(returnTime).difference(DateTime.parse(now)).inMinutes;
    final int timeToCollect =
        DateTime.parse(collectTime).difference(DateTime.parse(now)).inMinutes;

    if (timeToReturn == 10) {
      return """Your borrowing period
ends in 10 minutes!""";
    } else if (timeToCollect == 0) {
      return """Your item is ready
to be collected!""";
    }
    return "";
  }
}
