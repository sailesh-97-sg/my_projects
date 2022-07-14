// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, avoid_print

import 'package:bitespot/main.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  String? errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        title: Text('Forgot Password'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 8),
            Lottie.asset('assets/forgot-password.json',
                width: 200, height: 200),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Form(
                    key: _formKey,
                    child: Column(children: [
                      SizedBox(height: 35),
                      Text('Forgot Password?\nPlease enter your email address.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.barlow(
                              textStyle: TextStyle(
                                  color: Colors.white, fontSize: 22))),
                      SizedBox(height: 20),
                      SizedBox(height: 20),
                      TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: _emailController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (email) =>
                            email != null && !EmailValidator.validate(email)
                                ? 'Enter a valid email'
                                : null,
                        decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.white),
                            errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.white),
                                borderRadius: BorderRadius.circular(25)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 3,
                                  color: Color.fromARGB(255, 254, 223, 50),
                                ),
                                borderRadius: BorderRadius.circular(25)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.white),
                                borderRadius: BorderRadius.circular(25)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 3,
                                  color: Color.fromARGB(255, 254, 223, 50),
                                ),
                                borderRadius: BorderRadius.circular(25))),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: 200,
                        height: 45,
                        child: ElevatedButton(
                            onPressed: () async {
                              final isValidKey =
                                  _formKey.currentState!.validate();
                              if (isValidKey) {
                                resetPassword();
                              }
                            },
                            child: Text('Reset Password',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18)),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.grey[350],
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.black, width: 3),
                                    borderRadius: BorderRadius.circular(20)))),
                      ),
                    ]))),
          ],
        ),
      ),
    ));
  } // BuildContext

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password Reset Email has been sent.')));

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
          (Route<dynamic> route) => false);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
} // State

