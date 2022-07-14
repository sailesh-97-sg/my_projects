// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:bitespot/user/verification_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'signup.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_beacon/flutter_beacon.dart';

import 'login.dart';

//use the bottom commented out code to remove firebase functionality (for testing or any other purposes)
// void main() {
//   runApp(MyApp());
// }
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  try {
    // or if you want to include automatic checking permission
    await flutterBeacon.initializeAndCheckScanning;
  } catch (e) {
    // library failed to initialize, check code and message
  }
  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'BiteSpot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.grey[850],
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey[850],
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Something went wrong...'),
            );
          } else if (snapshot.hasData) {
            return VerifyEmail();
          } else {
            return Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset('assets/food-app.json'),
                  Text('BiteSpot',
                      style: GoogleFonts.arsenal(
                          textStyle:
                              TextStyle(fontSize: 35, color: Colors.white))),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: Text('Log In',
                            style:
                                TextStyle(color: Colors.black, fontSize: 18)),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.grey[350],
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.black, width: 3),
                                borderRadius: BorderRadius.circular(20)))),
                  ),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupPage()));
                        },
                        child: Text('Sign Up',
                            style:
                                TextStyle(color: Colors.black, fontSize: 18)),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.grey[350],
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.black, width: 3),
                                borderRadius: BorderRadius.circular(20)))),
                  ),
                ],
              ),
            );
          }
        },
      ),
      // body: Container(
      //   width: MediaQuery.of(context).size.width,
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       Lottie.asset('assets/food-app.json'),
      //       Text('BiteSpot',
      //           style: GoogleFonts.arsenal(
      //               textStyle:
      //                   TextStyle(fontSize: 35, color: Colors.white))),
      //       SizedBox(height: 20),
      //       SizedBox(
      //         width: 200,
      //         child: ElevatedButton(
      //             onPressed: () {
      //               Navigator.push(
      //                   context,
      //                   MaterialPageRoute(
      //                       builder: (context) => LoginPage()));
      //             },
      //             child: Text('Log In',
      //                 style: TextStyle(color: Colors.black, fontSize: 18)),
      //             style: ElevatedButton.styleFrom(
      //                 primary: Colors.grey[350],
      //                 shape: RoundedRectangleBorder(
      //                     side: BorderSide(color: Colors.black, width: 3),
      //                     borderRadius: BorderRadius.circular(20)))),
      //       ),
      //       SizedBox(
      //         width: 200,
      //         child: ElevatedButton(
      //             onPressed: () {
      //               Navigator.push(
      //                   context,
      //                   MaterialPageRoute(
      //                       builder: (context) => SignupPage()));
      //             },
      //             child: Text('Sign Up',
      //                 style: TextStyle(color: Colors.black, fontSize: 18)),
      //             style: ElevatedButton.styleFrom(
      //                 primary: Colors.grey[350],
      //                 shape: RoundedRectangleBorder(
      //                     side: BorderSide(color: Colors.black, width: 3),
      //                     borderRadius: BorderRadius.circular(20)))),
      //       ),
      //     ],
      //   ),
      // )),
    ));
  }
}
