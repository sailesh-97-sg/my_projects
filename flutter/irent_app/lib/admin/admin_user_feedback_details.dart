// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:irent_app/app_icons.dart';
import 'admin_constants.dart';
import 'admin_user_feedback.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class UserFeedbackDetailsPage extends StatelessWidget {
  final Color white = const Color(0xFFFBFBFF);
  final Color oxford = const Color(0xFF001D4A);
  final Color aliceblue = const Color(0xFF81A4CD);
  final Color iceberg = const Color(0xFFDBE4EE);
  final Color marigold = const Color(0xFFECA400);
  final Color transparent = const Color(0x4DE3E3E3);

  final FeedbackDataModel feedbackDataModel;
  const UserFeedbackDetailsPage({Key? key, required this.feedbackDataModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
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
                      'User Feedback',
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
                            Icons.arrow_back,
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
            child: Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(left: 30),
                    child: _feedbackDetails(
                      user: feedbackDataModel.user,
                      itemName: feedbackDataModel.itemName,
                      submissionTime: feedbackDataModel.submissionTime,
                      ticketNumber: feedbackDataModel.ticketNumber,
                      feedbackType: feedbackDataModel.feedbackType,
                      comment: feedbackDataModel.comment,
                      displayPicture: feedbackDataModel.displayPicture,
                    )),
                SizedBox(
                  height: screenheight * 0.15,
                ),
                SizedBox(
                  height: 50,
                  width: 150,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(38.0),
                    ),
                    onPressed: !feedbackDataModel.resolved
                        ? () {
                            resolveTicket()
                                .then((value) => Navigator.pop(context));
                          }
                        : null,
                    padding: EdgeInsets.all(10.0),
                    color: marigold,
                    textColor: white,
                    child: Align(
                      alignment: Alignment.center,
                      child: !feedbackDataModel.resolved
                          ? Text(
                              "Resolve",
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: "SF_Pro_Rounded",
                                color: white,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          : Text(
                              "Resolved",
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: "SF_Pro_Rounded",
                                color: white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenheight * 0.05,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Future resolveTicket() async {
    FirebaseFirestore.instance
        .collection('feedback')
        .doc(feedbackDataModel.ticketNumber.toString())
        .update({'resolved': true});
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

  Widget _feedbackDetails({
    required String user,
    required String itemName,
    required Timestamp submissionTime,
    required int ticketNumber,
    required String feedbackType,
    required String comment,
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
          height: 20,
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
                  subtitle: '#$ticketNumber',
                  width: double.infinity),
            ),
            Expanded(
              flex: 1,
              child: _fields(
                  title: 'User', subtitle: user, width: double.infinity),
            ),
          ],
        ),
        _fields(
            title: 'Submission Time',
            subtitle: DateFormat('dd/MM/yyyy, kk:mm:ss a')
                .format(submissionTime.toDate()),
            width: double.infinity),
        _fields(
            title: 'Feedback Type',
            subtitle: feedbackType,
            width: double.infinity),
        _fields(
          title: 'Comments',
          subtitle: comment,
          width: double.infinity,
        ),
      ],
    );
  }
}
