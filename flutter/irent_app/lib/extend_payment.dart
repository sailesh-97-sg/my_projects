import 'package:flutter/material.dart';
import 'user_bookings.dart';

class extend_payment extends StatefulWidget {
  const extend_payment({Key? key}) : super(key: key);

  @override
  State<extend_payment> createState() => _extend_paymentState();
}

class _extend_paymentState extends State<extend_payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Payment',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color(0xFF001D4A),
              fontFamily: 'SF_Pro_Rounded',
              fontSize: 25,
              fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  color: Colors.blue,
                ),
              ],
            ),
            Column(
              children: [
                Container(
                    padding: EdgeInsets.only(top: 30),
                    child: Text(
                      'Payment Successful',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFF001D4A),
                          fontFamily: 'SF Pro Rounded',
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          height: 1),
                    )),
              ],
            ),
            Column(
              children: [
                Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      'Total Payment: ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xFF001D4A),
                          fontFamily: 'SF Pro Rounded',
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          height: 1),
                    )),
              ],
            ),
            Column(
              children: [
                Container(
                    child: Text(
                  ' \$2',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF001D4A),
                      fontFamily: 'SF Pro Rounded',
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      height: 1),
                )),
              ],
            ),
            Column(
              children: [
                Container(
                    padding: EdgeInsets.only(top: 60, bottom: 10),
                    child: SizedBox(
                      width: 160,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => user_bookings())));
                        },
                        child: Text(
                          'Go to Bookings',
                          style: TextStyle(
                              color: Color(0xFFFBFBFF),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
