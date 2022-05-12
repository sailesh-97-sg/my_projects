// ignore_for_file: prefer_const_constructors, deprecated_member_use
//firebase firestore https://www.youtube.com/watch?v=1_xKjeQXa3A
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:irent_app/app_icons.dart';
import 'package:irent_app/not_verified.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final Color white = const Color(0xFFFBFBFF);
  final Color oxford = const Color(0xFF001D4A);
  final Color indigo = const Color(0xFF27476E);
  final Color aliceblue = const Color(0x8081A4CD);
  final Color marigold = const Color(0xFFECA400);
  final TextStyle labels = TextStyle(
      color: Color(0x80001D4A), fontFamily: 'SF_Pro_Rounded', fontSize: 16);
  final TextStyle hints = TextStyle(
      color: Color(0x80001D4A), fontFamily: 'SF_Pro_Rounded', fontSize: 15);

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  bool agree = false;
  bool? _success;
  String _userEmail = '';
  String _register_reason = '';
  String? errorMessage;

  @override
  bool value = false;
  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: oxford),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Form(
              key: _formKey,
              child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    SizedBox(
                      height: screenheight * 0.01,
                    ),
                    Center(
                      child: DropShadowImage(
                        image: Image.asset(
                          'images/irent-logo.png',
                          width: MediaQuery.of(context).size.width * 0.15,
                        ),
                        borderRadius: 10,
                        offset: Offset(0, 5),
                        blurRadius: 10,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Create Account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'SF_Pro_Rounded',
                          color: oxford),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Please create an account with your student email\n (e.g. user@e.ntu.edu.sg)',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'SF_Pro_Rounded',
                          color: oxford,
                          fontSize: 15),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: aliceblue)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: aliceblue)),
                            labelText: 'Name',
                            labelStyle: labels,
                            hintStyle: hints,
                            prefixIcon: Icon(
                              AppIcons.person,
                              color: Color(0x80001D4A),
                            ),
                            hintText: 'John Smith')),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _emailController,
                      validator: (String? value) {
                        bool emailValid =
                            RegExp(r'^[A-Za-z0-9._%+-]+@e.ntu.edu.sg$')
                                .hasMatch(value!);
                        if (value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!emailValid && value.isNotEmpty) {
                          return 'Please use NTU Email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: aliceblue)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: aliceblue)),
                          labelText: 'Email',
                          labelStyle: labels,
                          hintStyle: hints,
                          hintText: 'JOHN001@e.ntu.edu.sg',
                          prefixIcon: Icon(
                            AppIcons.email,
                            color: Color(0x80001D4A),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _phoneNumberController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your mobile number';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: aliceblue)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: aliceblue)),
                          hintText: '9245XXXX',
                          hintStyle: hints,
                          labelText: 'Mobile No.',
                          labelStyle: labels,
                          prefixIcon: Icon(
                            AppIcons.phone,
                            color: Color(0x80001D4A),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: '*******',
                          hintStyle: hints,
                          labelText: 'Password',
                          labelStyle: labels,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: aliceblue)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: aliceblue)),
                          prefixIcon: Icon(
                            AppIcons.password,
                            color: Color(0x80001D4A),
                          )),
                      obscureText: true,
                    ),
                    SizedBox(
                      height: screenheight * 0.03,
                    ),
                    Row(
                      children: [
                        // for checkbox validation link, check https://www.kindacode.com/article/flutter-i-agree-to-terms-checkbox-example/
                        Checkbox(
                            activeColor: indigo,
                            value: agree,
                            onChanged: (value) {
                              setState(() {
                                agree = value ?? false;
                              });
                            }),
                        SizedBox(
                            width: 250,
                            child: Text(
                              'By clicking this button, you are agreeing to our Terms of Services and Privacy Policy',
                              style: TextStyle(
                                  color: Color(0xFF001D4A),
                                  fontFamily: 'SF_Pro_Rounded',
                                  fontSize: 14),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: screenheight * 0.1,
                    ),
                    ButtonTheme(
                      minWidth: 300,
                      height: 45,
                      child: RaisedButton(
                        onPressed: agree
                            ? () {
                                _register(_emailController.text,
                                    _passwordController.text);
                              }
                            : null,
                        color: Color(0xFFECA400),
                        child: Text(
                          'Register',
                          style: TextStyle(color: Color(0xFFFBFBFF)),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        _success == null
                            ? ''
                            : (_success!
                                ? 'Successfully registered $_userEmail'
                                : 'Registration failed ($_register_reason)'),
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _register(String emailField, String passwordField) async {
    final firebase_storage.Reference firebaseStorageRef = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child("users/default/profile.png");
    var downloadUrl = await firebaseStorageRef.getDownloadURL();
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(
                email: emailField, password: passwordField)
            .then((user) => {
                  user.user?.sendEmailVerification(),
                  users.doc(user.user?.uid).set({
                    'email': _emailController.text,
                    'name': _nameController.text,
                    'phone_number': int.parse(_phoneNumberController.text),
                    'wallet': 0,
                    'role': 'user',
                    'profileURL': downloadUrl.toString()
                  }),
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NotVerified()))
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
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
          case "email-already-in-use":
            errorMessage = "User with this email already exists.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errorMessage!)));
        print(error.code);
      }
    }
  }
}
