// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:bitespot/main.dart';
import 'user/verification_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  String? errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        title: Text('Sign Up'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Lottie.asset('assets/user-profile.json', width: 200, height: 200),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Form(
                    key: _formKey,
                    child: Column(children: [
                      SizedBox(height: 25),
                      Text('Create Account',
                          style: GoogleFonts.barlow(
                              textStyle: TextStyle(
                                  color: Colors.white, fontSize: 22))),
                      SizedBox(height: 20),
                      TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Name',
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
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.white),
                                borderRadius: BorderRadius.circular(25)),
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
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 3,
                                  color: Color.fromARGB(255, 254, 223, 50),
                                ),
                                borderRadius: BorderRadius.circular(25))),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: _phoneNumberController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your mobile number';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Mobile Number',
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
                      TextFormField(
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),
                        controller: _passwordController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => value != null && value.length < 6
                            ? 'Enter a minimum of 6 characters'
                            : null,
                        decoration: InputDecoration(
                            labelText: 'Password',
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
                        width: 150,
                        height: 45,
                        child: ElevatedButton(
                            onPressed: () async {
                              final isValidForm =
                                  _formKey.currentState!.validate();
                              if (isValidForm) {
                                await signUp();
                                // FirebaseAuth.instance
                                //     .authStateChanges()
                                //     .listen((User? user) {
                                //   if (user == null) {
                                //     print('user is signed out!');
                                //   } else {
                                //     Navigator.pushAndRemoveUntil(
                                //         context,
                                //         MaterialPageRoute(
                                //             builder: (context) => MainPage()),
                                //         (Route<dynamic> route) => false);
                                //   }
                                // });
                              }

                              // Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: ((context) => MainPage())));
                            },
                            child: Text('Sign Up',
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
  }

  Future signUp() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim())
          .then((value) => FirebaseAuth.instance.currentUser!
              .updateDisplayName(
                _nameController.text.trim(),
              )
              .then((user) => {
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .set({
                      'name': _nameController.text,
                      'email': _emailController.text,
                      'phone_number': _phoneNumberController.text,
                      'role': 'user',
                      'registered_date': DateTime.now().toString(),
                      'wallet': 0
                    })
                  })
              .then((value) => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VerifyEmail()),
                  )));
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          errorMessage = "This email is already in use.";
          break;
        case "invalid-email":
          errorMessage = "The provied email is not valid";
          break;

        case "weak-password":
          errorMessage = "The provided password is weak.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "Please enter your account details";
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage!)));
    }

    navigatorKey.currentState!.popUntil(((route) => route.isActive));
  }
}//State
