import 'package:flutter/material.dart';
import 'package:irent_app/switch_nav.dart';

class user_payment_successful extends StatefulWidget {
  final int totalPayment;
  const user_payment_successful({Key? key, required this.totalPayment})
      : super(key: key);

  @override
  State<user_payment_successful> createState() =>
      _user_payment_successfulState();
}

class _user_payment_successfulState extends State<user_payment_successful> {
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset('images/checked.png', height: 177, width: 177),
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
                  ' \$${widget.totalPayment}',
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
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => SwitchNavBar())));
                        },
                        child: Text(
                          'Return to Homepage',
                          textAlign: TextAlign.center,
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
