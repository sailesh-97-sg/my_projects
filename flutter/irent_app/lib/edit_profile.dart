// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:irent_app/account.dart';
import 'package:irent_app/authservice.dart';
import 'package:irent_app/database.dart';
import 'package:irent_app/login_register.dart';
import 'package:irent_app/profilepage.dart';
import 'package:irent_app/switch_nav.dart';
import 'database.dart';
import 'homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:irent_app/app_icons.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
String? uid = FirebaseAuth.instance.currentUser?.uid;
CollectionReference updateProfile =
    FirebaseFirestore.instance.collection('users');

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser;

  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _nameField = TextEditingController();
  final TextEditingController _mobileNumberField = TextEditingController();

  final TextEditingController _passwordField = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Color white = const Color(0xFFFBFBFF);
  final Color oxford = const Color(0xFF001D4A);
  final Color iceberg = const Color(0xFF27476E);
  final Color aliceblue = const Color(0xFF81A4CD);
  final Color marigold = const Color(0xFFECA400);
  final Color transparent = const Color(0x4DE3E3E3);
  bool? _success;
  String? _userEmail;
  String? _userName;
  File? _myImage;
  File? selectedImage;
  String nameHint = "";
  String emailHint = "";

  // File _myImageState = File('');

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
                          //height: screenheight * 0.15,
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
                            'Edit Profile',
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
                        SizedBox(height: 30),
                        // StreamBuilder(
                        //   stream: FirebaseFirestore.instance
                        //       .collection('users')
                        //       .doc(uid)
                        //       .snapshots(),
                        //   builder: (BuildContext context,
                        //       AsyncSnapshot<DocumentSnapshot> snapshot) {
                        //     if (snapshot.hasError) {
                        //       return Text('Something went wrong...');
                        //     }
                        //     if (snapshot.connectionState ==
                        //         ConnectionState.waiting) {
                        //       return Text('Loading...');
                        //     }
                        //     return TextFormField(
                        //       controller: _nameField,
                        //       validator: (value) {
                        //         if (value == null || value.isEmpty) {
                        //           return 'Please enter your name';
                        //         }
                        //         return null;
                        //       },
                        //       decoration: InputDecoration(
                        //           labelText: 'Name',
                        //           hintText: snapshot.data!['name'],
                        //           prefixIcon: Icon(AppIcons.person),
                        //           floatingLabelBehavior:
                        //               FloatingLabelBehavior.always),
                        //     );
                        //   },
                        // ),
                        TextFormField(
                          controller: _nameField,
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Please enter your name';
                          //   }
                          //   return null;
                          // },
                          decoration: InputDecoration(
                              labelText: 'Name',
                              // hintText: 'John Smith',
                              hintText: nameHint,
                              prefixIcon: Icon(AppIcons.person),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _emailField,
                          decoration: InputDecoration(
                              enabled: false,
                              labelText: 'Email',
                              hintText: emailHint,
                              // hintText:
                              //     FirebaseAuth.instance.currentUser?.email,
                              prefixIcon: Icon(AppIcons.email),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // TextFormField(
                        //   controller: _mobileNumberField,
                        //   // validator: (value) {
                        //   //   if (value == null || value.isEmpty) {
                        //   //     return 'Please enter your mobile number';
                        //   //   }
                        //   //   return null;
                        //   // },
                        //   decoration: InputDecoration(
                        //       labelText: 'Mobile No',
                        //       hintText: '9245XXXX',
                        //       prefixIcon: Icon(AppIcons.phone),
                        //       floatingLabelBehavior:
                        //           FloatingLabelBehavior.always),
                        // ),
                        SizedBox(
                          height: screenheight * 0.22,
                        ),
                        SizedBox(
                          width: 160,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if ((_nameField.text != "") ||
                                    _myImage != null) {
                                  String nameChange = _nameField.text;
                                  if (_nameField.text == "") {
                                    nameChange = nameHint;
                                  }
                                  String updateProfile = await AuthService()
                                      .changeProfile(uid, nameChange, _myImage);
                                  if (updateProfile == 'success') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Your profile has been updated.')));
                                    Navigator.pop(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AccountScreen()));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Error: Your profile is not updated.')));
                                  }
                                } else {
                                  Navigator.pop(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AccountScreen()));
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
          Align(
              alignment: Alignment(0, -0.55),
              child: Stack(children: [
                StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(uid)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong...');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text('Loading...');
                      }
                      if (snapshot.hasData) {
                        return CircleAvatar(
                          backgroundImage: _myImage == null
                              ? (NetworkImage(snapshot.data!['profileURL']))
                              : (FileImage(_myImage as File) as ImageProvider),
                          radius: 50,
                        );
                      } else {
                        return CircleAvatar(
                          radius: 50,
                        );
                      }
                    }),
                Positioned(
                    bottom: -5,
                    right: -5,
                    child: RawMaterialButton(
                      constraints: BoxConstraints.tight(Size(35, 35)),
                      onPressed: () async {
                        selectedImage = await selectImage();
                        if (selectedImage != null) {
                          setState(() {
                            _myImage = selectedImage as File;
                          });
                        }
                      },
                      elevation: 2.0,
                      fillColor: white,
                      child: Icon(
                        Icons.edit,
                        color: iceberg,
                        size: 20,
                      ),
                      shape: CircleBorder(),
                    ))
              ]))
        ],
      ),
    );
  }

  Future<void> updateUser() {
    return updateProfile
        .doc(uid)
        .update({
          'name': _nameField.text,
          'email': _emailField.text,
          'phone_number': _mobileNumberField.text
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

//Not edited
  Future<void> _signInWithEmailAndPassword() async {
    final User? user = (await _auth.signInWithEmailAndPassword(
      email: _emailField.text,
      password: _passwordField.text,
    ))
        .user;

    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email;
      });
    } else {
      setState(() {
        _success = false;
      });
    }
  }

  @override
  void initState() {
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection('users');
    userCollection.doc(uid).get().then((DocumentSnapshot datas) {
      try {
        setState(() {
          nameHint = datas.get(FieldPath(['name']));
          emailHint = datas.get(FieldPath(['email']));
        });
      } on StateError catch (e) {
        print('No nested field exists!');
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailField.dispose();
    _passwordField.dispose();
    _mobileNumberField.dispose();
    _myImage = null;
    super.dispose();
  }
}
