// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers
// https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html for Bottom Navigation Bar
// https://www.youtube.com/watch?v=xoKqQjSDZ60&t=125s for video on bottomnavigationbar implementation
import 'package:flutter/material.dart';
import 'drawer.dart';
import 'profilepage.dart';
import 'homeview.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final screens = [
    HomeView(),
    Center(
      child: Text(
        'Bookings',
        style: TextStyle(fontSize: 60),
      ),
    ),
    Center(
      child: Text(
        'Cart',
        style: TextStyle(fontSize: 60),
      ),
    ),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Theme(
            data: Theme.of(context).copyWith(canvasColor: Colors.grey),
            child: NavigationDrawer()),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          selectedItemColor: Colors.black,
          iconSize: 30,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (index) => setState(() => currentIndex = index),
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Bookings'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag), label: 'Cart'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account')
          ],
        ),
      ),
    );
  }
}
