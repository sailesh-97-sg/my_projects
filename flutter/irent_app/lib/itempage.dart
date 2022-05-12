// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({Key? key}) : super(key: key);

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    var fullwidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
            width: fullwidth,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://danielfooddiary.com/wp-content/uploads/2020/05/pratasingapore3.jpg"),
                          fit: BoxFit.cover)),
                  height: 300,
                  width: fullwidth,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Deluxe Prata',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  textAlign: TextAlign.start,
                )
              ],
            )),
      ),
    );
  }
}
