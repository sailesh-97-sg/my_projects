// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, avoid_print

import 'package:bitespot/user/forgot_password.dart';
import 'package:bitespot/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'admin/admin_home_page.dart';
import 'organization/organization_home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Lottie.asset('assets/login.json', width: 200, height: 200),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Form(
                    key: _formKey,
                    child: Column(children: [
                      SizedBox(height: 25),
                      Text('Welcome Back',
                          style: GoogleFonts.barlow(
                              textStyle: TextStyle(
                                  color: Colors.white, fontSize: 22))),
                      SizedBox(height: 20),
                      SizedBox(height: 20),
                      TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
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
                      TextFormField(
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
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
                        width: 200,
                        height: 45,
                        child: ElevatedButton(
                            onPressed: () async {
                              final isValidKey =
                                  _formKey.currentState!.validate();
                              if (isValidKey) {
                                await signIn();
                                FirebaseAuth.instance
                                    .authStateChanges()
                                    .listen((User? user) {
                                  if (user == null) {
                                    print('user is signed out!');
                                  } else {
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .get()
                                        .then((value) => {
                                              if (value.exists)
                                                {
                                                  if (value.data()?['role'] ==
                                                      "admin")
                                                    {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                AdminHomePage()),
                                                      )
                                                    }
                                                  else if (value
                                                          .data()?['role'] ==
                                                      "organization")
                                                    {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                OrganizationHomePage()),
                                                      )
                                                    }
                                                  else
                                                    {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    MainPage()),
                                                      )
                                                    }
                                                }
                                            });

                                    // Navigator.pushReplacement(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) => HomePage(),
                                    //     ));
                                  }
                                });
                              }

                              // Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: ((context) => MainPage())));
                            },
                            child: Text('Login',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18)),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.grey[350],
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.black, width: 3),
                                    borderRadius: BorderRadius.circular(20)))),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        child: Text('Forgot your password?',
                            style: TextStyle(color: Colors.white)),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => ResetPassword())));
                        },
                      )
                    ]))),
          ],
        ),
      ),
    ));
  } // BuildContext

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "You entered an invalid email address format.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "Please enter your login details.";
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage!)));
      print(error.code);
    }
    navigatorKey.currentState!.popUntil((route) => route.isActive);
  }
} // State
