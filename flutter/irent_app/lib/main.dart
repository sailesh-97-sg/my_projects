// ignore_for_file: prefer_const_constructors, deprecated_member_use
// /https://www.youtube.com/watch?v=zpbyJ7GVMVU

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:irent_app/login_register.dart';
import 'package:irent_app/switch_nav.dart';

import 'admin/admin_switch_nav.dart';
import 'firebase_options.dart';
import 'login_register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xFFFBFBFF),
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.email!.contains('admin')) {
                return AdminSwitchNavBar();
              }
              return SwitchNavBar();
            } else {
              return LoginRegisterScreen();
            }
          },
        ),
      );
}
