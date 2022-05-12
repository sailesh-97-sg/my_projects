import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'database.dart';

class DateTimeTest extends StatefulWidget {
  const DateTimeTest({Key? key}) : super(key: key);

  @override
  _DateTimeTestState createState() => _DateTimeTestState();
}

String? uid = FirebaseAuth.instance.currentUser?.uid;
DateTimeRange dateRange = DateTimeRange(
  start: DateTime.now(),
  end: DateTime.now(),
);
final start = dateRange.start;
final end = dateRange.end;
final difference = dateRange.duration;
Timestamp bookingStartDate = Timestamp.fromDate(start);
Timestamp bookingEndDate = Timestamp.fromDate(end);

class _DateTimeTestState extends State<DateTimeTest> {
  DocumentReference users =
      FirebaseFirestore.instance.collection('users').doc(uid);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('DateTime Tester'),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.only(top: 50, left: 30, right: 30),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: pickDateRange,
                        child: Text(DateFormat('dd/MM/yyyy').format(start)),
                      )),
                  Container(
                      margin: EdgeInsets.only(left: 30),
                      width: 150,
                      child: ElevatedButton(
                          onPressed: pickDateRange,
                          child: Text(DateFormat('dd/MM/yyyy').format(end))))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text('Duration: ${difference.inDays} days'),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('time'),
                  )),
              Container(
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () async {
                    await setBookingDate();
                  },
                  child: Text('Book Now'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> setBookingDate() async {
    try {
      users.update({'startdate': bookingStartDate, 'endDate': bookingEndDate});
    } catch (e) {
      print('an error has occured!');
    }
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        initialDateRange: dateRange,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));

    if (newDateRange == null) return;
    setState(() => dateRange = newDateRange);
  }
}
