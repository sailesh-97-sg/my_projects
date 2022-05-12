// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:irent_app/app_icons.dart';
import 'package:irent_app/switch_nav.dart';
import 'admin_constants.dart';
import 'admin_user_feedback_details.dart';
import 'admin_alert_details.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class AdminAlertPage extends StatefulWidget {
  const AdminAlertPage({Key? key}) : super(key: key);

  @override
  State<AdminAlertPage> createState() => _AdminAlertPageState();
}

class _AdminAlertPageState extends State<AdminAlertPage> {
  final Color white = const Color(0xFFFBFBFF);
  final Color oxford = const Color(0xFF001D4A);
  final Color aliceblue = const Color(0xFF81A4CD);
  final Color iceberg = const Color(0xFFDBE4EE);
  final Color marigold = const Color(0xFFECA400);
  final Color transparent = const Color(0x4DE3E3E3);

  final TextStyle subtitleStyle = TextStyle(
    color: Color(0xFF001D4A),
    fontSize: 20,
    fontFamily: 'SF_Pro_Rounded',
    fontWeight: FontWeight.w500,
  );

  final List<AlertDataModel> alerts = List.generate(
      alertData.length,
      (index) => AlertDataModel(
            '${alertData[index]['user']}',
            '${alertData[index]['itemName']}',
            '${alertData[index]['ticketNumber']}',
            '${alertData[index]['returnTime']}',
            '${alertData[index]['displayPicture']}',
            '${alertData[index]['prevImage']}',
            '${alertData[index]['currentImage']}',
          ));

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
                      'Alert',
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
                itemCount: userFeedbackData.length,
                itemBuilder: (context, index) {
                  for (var item in userFeedbackData) {
                    return _alertCard(
                      context: context,
                      index: index,
                      itemName: alerts[index].itemName,
                      ticketNumber: int.parse(alerts[index].ticketNumber),
                      displayPicture: alerts[index].displayPicture,
                    );
                  }
                  throw 'No Data Found';
                }),
          ),
        ),
      ]),
    );
  }

  Widget _alertCard({
    required BuildContext context,
    required int index,
    required String itemName,
    required int ticketNumber,
    required String displayPicture,
  }) {
    final TextStyle subtitleStyles = TextStyle(
      fontFamily: 'SF_Pro_Rounded',
      fontSize: 13,
      fontWeight: FontWeight.w300,
      color: Color(0xFF001D4A),
      wordSpacing: 1,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        child: Card(
          color: Color(0xFFDBE4EE),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 8, top: 10, bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                  child: ListTile(
                    leading: Image.asset(
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
                        Text('Alert! Item is missing. Please check.',
                            style: subtitleStyles),
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
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AdminAlertDetailsPage(alertDataModel: alerts[index]),
              ));
        },
      ),
    );
  }
}

class AlertDataModel {
  final String user,
      itemName,
      ticketNumber,
      returnTime,
      displayPicture,
      prevImage,
      currentImage;

  AlertDataModel(this.user, this.itemName, this.ticketNumber, this.returnTime,
      this.displayPicture, this.prevImage, this.currentImage);
}
