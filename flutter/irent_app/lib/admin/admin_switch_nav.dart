// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:irent_app/admin/admin_transactions.dart';
import '../app_icons.dart';
import 'package:irent_app/app_icons.dart';
import 'admin_home.dart';
import 'admin_bookings.dart';
import 'admin_account.dart';
import 'admin_constants.dart';
import 'admin_home_back.dart';

class AdminSwitchNavBar extends StatefulWidget {
  const AdminSwitchNavBar({Key? key}) : super(key: key);

  @override
  State<AdminSwitchNavBar> createState() => _AdminSwitchNavBarState();
}

class _AdminSwitchNavBarState extends State<AdminSwitchNavBar> {
  final Color white = const Color(0xFFFBFBFF);
  final Color oxford = const Color(0xFF001D4A);
  final Color aliceblue = const Color(0xFF81A4CD);
  final Color iceberg = const Color(0xFFDBE4EE);
  final Color marigold = const Color(0xFFECA400);
  final Color transparent = const Color(0x4DE3E3E3);
  final TextStyle notifTitleStyle = TextStyle(
    fontFamily: 'SF_Pro_Rounded',
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Color(0xFF001D4A),
  );

  int _selectedIndex = 0;
  static const TextStyle titleStyle = TextStyle(
      fontSize: 25, color: Color(0xFF001D4A), fontWeight: FontWeight.w500);
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
      'Transactions',
      style: titleStyle,
    ),
    Text(
      'Account',
      style: titleStyle,
    ),
  ];
  final List<Widget> _bodyContents = <Widget>[
    admin_home(),
    admin_bookings(),
    admin_transactions(),
    AdminAccountScreen(),
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
                                  notif['receiveTime'].toString(),
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
                  AppIcons.wallet,
                  size: 30,
                ),
                label: "Wallet"),
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

  Widget _notifItem(String storeName, String itemName, String receiveTime,
      int ticket, String image) {
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
                    'Feedback Received',
                    style: notifStyle,
                  )
                ],
              ),
              Spacer(),
              Container(
                alignment: Alignment.topRight,
                child: Text(
                  _notifTime(receiveTime),
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

  String _notifTime(String receiveTime) {
    final int timeStamp =
        DateTime.parse(now).difference(DateTime.parse(receiveTime)).inMinutes;

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
