import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class user_notcollect extends StatefulWidget {
  const user_notcollect({Key? key}) : super(key: key);

  @override
  _user_notcollectState createState() => _user_notcollectState();
}

class _user_notcollectState extends State<user_notcollect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Collect',
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/embarrassed.png", height: 160, width: 160),
            SizedBox(height: 60),
            Container(
                width: 321,
                height: 96,
                child: Text(
                  'Oops! \nIt not time to Collect \nyour item yet. \nPlease come back later.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(0, 29, 74, 1),
                      fontFamily: 'SF Pro Rounded',
                      fontSize: 20,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1),
                )),
          ],
        ),
      ),
    );
  }
}
