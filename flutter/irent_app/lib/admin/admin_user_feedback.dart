// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
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

class AdminUserFeedbackPage extends StatefulWidget {
  const AdminUserFeedbackPage({Key? key}) : super(key: key);

  @override
  State<AdminUserFeedbackPage> createState() => _AdminUserFeedbackPageState();
}

class _AdminUserFeedbackPageState extends State<AdminUserFeedbackPage> {
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

  // final List<FeedbackDataModel> userFeedbacks = List.generate(
  //     userFeedbackData.length,
  //     (index) => FeedbackDataModel(
  //           '${userFeedbackData[index]['user']}',
  //           '${userFeedbackData[index]['itemName']}',
  //           '${userFeedbackData[index]['ticketNumber']}',
  //           '${userFeedbackData[index]['submissionTime']}',
  //           '${userFeedbackData[index]['displayPicture']}',
  //           '${userFeedbackData[index]['feedbackType']}',
  //           '${userFeedbackData[index]['comments']}',
  //         ));
  List userFeedbacks = [];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getFeedback();
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
                itemCount: userFeedbacks.length,
                itemBuilder: (context, index) {
                  // for (var item in userFeedbackData) {
                  return _userFeedbackCard(
                      context: context,
                      index: index,
                      user: userFeedbacks[index].user,
                      itemName: userFeedbacks[index].itemName,
                      submissionTime: userFeedbacks[index].submissionTime,
                      ticketNumber: userFeedbacks[index].ticketNumber,
                      displayPicture: userFeedbacks[index].displayPicture,
                      feedbackType: userFeedbacks[index].feedbackType,
                      comment: userFeedbacks[index].comment,
                      resolved: userFeedbacks[index].resolved);
                  // }
                  // throw 'No Data Found';
                }),
          ),
        ),
      ]),
    );
  }

  Widget _userFeedbackCard(
      {required BuildContext context,
      required int index,
      required String user,
      required String itemName,
      required Timestamp submissionTime,
      required int ticketNumber,
      required String displayPicture,
      required String feedbackType,
      required String comment,
      required bool resolved}) {
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
                        Text('Feedback Received from User',
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
                builder: (context) => UserFeedbackDetailsPage(
                    feedbackDataModel: userFeedbacks[index]),
              ));
        },
      ),
    );
  }

  getFeedback() {
    FirebaseFirestore.instance
        .collection('feedback')
        .snapshots()
        .listen((data) {
      setState(() {
        userFeedbacks = List.from(
                data.docs.map((doc) => FeedbackDataModel.fromSnapshot(doc)))
            .reversed
            .toList();
        // storeData = newstores;
      });
    });
  }
}

class FeedbackDataModel {
  String displayPicture = "",
      itemName = "",
      item_id = "",
      comment = "",
      shop = "",
      feedbackType = "",
      user = "";
  int ticketNumber = 0;
  Timestamp submissionTime = Timestamp.now();
  bool resolved = false;

  FeedbackDataModel();
  Map<String, dynamic> toJson() => {
        "displayPicture": displayPicture,
        "item": itemName,
        "item_id": item_id,
        "message": comment,
        "shop": shop,
        "submissionTime": submissionTime,
        "type": feedbackType,
        "user": user,
        "feedback_id": ticketNumber,
        "resolved": resolved
      };

  FeedbackDataModel.fromSnapshot(snapshot)
      : displayPicture = snapshot.data()["displayPicture"],
        itemName = snapshot.data()["itemName"],
        item_id = snapshot.data()["item_id"],
        comment = snapshot.data()["comment"],
        shop = snapshot.data()["shop"],
        submissionTime = snapshot.data()["submissionTime"],
        feedbackType = snapshot.data()["feedbackType"],
        user = snapshot.data()["user"],
        ticketNumber = snapshot.data()["ticketNumber"],
        resolved = snapshot.data()["resolved"];
}
