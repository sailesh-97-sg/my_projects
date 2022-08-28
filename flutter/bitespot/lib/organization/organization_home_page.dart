// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:bitespot/organization/organization_home_screen.dart';
import 'package:bitespot/organization/organization_orders_page.dart';
import 'package:bitespot/organization/organization_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../main.dart';

class OrganizationHomePage extends StatefulWidget {
  const OrganizationHomePage({Key? key}) : super(key: key);

  @override
  State<OrganizationHomePage> createState() => _OrganizationHomePageState();
}

class _OrganizationHomePageState extends State<OrganizationHomePage> {
  int index = 0;
  final screens = [
    OrganizationHomeScreen(),
    OrganizationOrdersPage(),
    OrganizationProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens[index],
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: Colors.blue.shade100,
            labelTextStyle: MaterialStateProperty.all(
                TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          ),
          child: NavigationBar(
            height: 60,
            backgroundColor: Color.fromARGB(255, 176, 176, 176),
            selectedIndex: index,
            onDestinationSelected: (index) =>
                setState(() => this.index = index),
            destinations: [
              NavigationDestination(icon: Icon(Icons.home), label: 'Current'),
              NavigationDestination(
                icon: Icon(Icons.list),
                label: 'Completed',
              ),
              NavigationDestination(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          title: Text('Organization Home Page'),
        ));
  }
}
