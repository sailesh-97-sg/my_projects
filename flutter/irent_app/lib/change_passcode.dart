// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:irent_app/authservice.dart';
import 'package:irent_app/login.dart';
import 'package:irent_app/login_register.dart';
import 'package:irent_app/switch_nav.dart';
import 'homepage.dart';
import 'package:irent_app/app_icons.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class ChangePasscodePage extends StatefulWidget {
  const ChangePasscodePage({Key? key}) : super(key: key);

  @override
  State<ChangePasscodePage> createState() => _ChangePasscodePageState();
}

class _ChangePasscodePageState extends State<ChangePasscodePage> {
  final currentUser = FirebaseAuth.instance.currentUser;
  var newPassword = "";
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Color white = const Color(0xFFFBFBFF);
  final Color oxford = const Color(0xFF001D4A);
  final Color aliceblue = const Color(0xFF81A4CD);
  final Color marigold = const Color(0xFFECA400);
  final Color transparent = const Color(0x4DE3E3E3);
  bool? _success;
  String? _userEmail;

  void dispose() {
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: white,
      body: Stack(
        children: [
          Column(
            children: [
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
                          'images/cross-bg-cropped.png',
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(height: screenheight * 0.1),
                          Container(
                            alignment: Alignment.bottomRight,
                            child: Image.asset(
                              'images/appbar.png',
                              height: screenheight * 0.15,
                            ),
                          )
                        ],
                      ),
                      Scaffold(
                        backgroundColor: Colors.transparent,
                        appBar: AppBar(
                          backgroundColor: Colors.transparent,
                          centerTitle: true,
                          title: Text(
                            'Change Password',
                            style: TextStyle(
                                color: oxford,
                                fontFamily: 'SF_Pro_Rounded',
                                fontSize: 25,
                                fontWeight: FontWeight.w500),
                          ),
                          elevation: 0,
                          leading: Row(
                            children: [
                              SizedBox(width: screenwidth * 0.05),
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
                flex: 3,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 40),
                  color: white,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          obscureText: true,
                          controller: newPasswordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your new password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'New Password',
                              hintText: '********',
                              prefixIcon: Icon(AppIcons.password),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          obscureText: true,
                          controller: confirmPasswordController,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                confirmPasswordController.text !=
                                    newPasswordController.text) {
                              return 'Please confirm your new password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: 'Confirm New Password',
                              hintText: '********',
                              prefixIcon: Icon(AppIcons.password),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always),
                        ),
                        SizedBox(
                          height: screenheight * 0.25,
                        ),
                        SizedBox(
                          width: 160,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  newPassword = confirmPasswordController.text;
                                });
                                String updatePassword = await AuthService()
                                    .changePassword(newPassword);
                                if (updatePassword == 'success') {
                                  FirebaseAuth.instance.signOut();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            LoginRegisterScreen(),
                                      ));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    backgroundColor: Colors.black26,
                                    content: Text(
                                        'Your password has been changed... Login again'),
                                  ));
                                } else if (updatePassword ==
                                    "requires-recent-login") {
                                  FirebaseAuth.instance.signOut();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            LoginRegisterScreen(),
                                      ));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    backgroundColor: Colors.black26,
                                    content: Text(
                                        'This operation is sensitive and requires recent authentication. Log in again before retrying this request.'),
                                  ));
                                } else {
                                  print(updatePassword);
                                }
                              }
                            },
                            child: Text(
                              'Save',
                              style: TextStyle(
                                  color: white,
                                  fontFamily: 'SF_Pro_Rounded',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xFFECA400),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(38))),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            _success == null
                                ? ''
                                : (_success!
                                    ? 'Successfully signed in ' + _userEmail!
                                    : 'Sign in failed'),
                            style: TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

//Not edited

}
