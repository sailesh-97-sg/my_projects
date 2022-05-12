import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:irent_app/admin/admin_constants.dart';
import 'package:irent_app/user_store_uroc.dart';
import 'package:irent_app/admin/admin_add_store.dart';
import 'dart:ui';
import '../app_icons.dart';
import 'package:irent_app/admin/admin_add_store.dart';
import 'package:irent_app/user_store_items.dart';

class user_home extends StatefulWidget {
  const user_home({Key? key}) : super(key: key);

  @override
  _user_homeState createState() => _user_homeState();
}

class _user_homeState extends State<user_home> {
  final Color white = const Color(0xFFFBFBFF);
  final Color oxford = const Color(0xFF001D4A);
  final Color aliceblue = const Color(0xFF81A4CD);
  final Color iceberg = const Color(0xFFDBE4EE);
  final Color marigold = const Color(0xFFECA400);
  final Color transparent = const Color(0x4DE3E3E3);

  List thestores = [];

  // final List<StoreDataModel> storeData = List.generate(
  //     stores.length,
  //     (index) => StoreDataModel(
  //           '${stores[index]['storeName']}',
  //           '${stores[index]['storeAddress']}',
  //           '${stores[index]['category']}',
  //           '${stores[index]['storeBanner']}',
  //           {stores[index]['itemCategories']}.toList(),
  //           {stores[index]['items']}.toList(),
  //         ));
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getStore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsetsDirectional.only(start: 35),
              child: Column(children: [
                Container(
                  height: 35,
                  width: 126,
                  //color: Colors.blue,
                  margin: EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Stores',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromRGBO(0, 29, 74, 1),
                      fontFamily: 'SF Pro Rounded',
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ]),
            ),
          ),
          Expanded(
            flex: 18,
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(left: 35, right: 35),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: thestores.length,
                    itemBuilder: (context, index) {
                      for (var item in stores) {
                        return _storeCard(
                            index: index,
                            storeName: thestores[index].storeName,
                            storeAddress: thestores[index].storeAddress,
                            category: thestores[index].category,
                            storeBanner: thestores[index].storeBanner);
                      }
                      throw 'No Data Found';
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _storeCard({
    required index,
    required storeName,
    required storeAddress,
    required category,
    required storeBanner,
  }) {
    const TextStyle titleStyle = TextStyle(
        color: Color(0xFFFBFBFF),
        fontFamily: 'SF Pro Rounded',
        fontSize: 17,
        letterSpacing: 0,
        fontWeight: FontWeight.w700);

    const TextStyle subtitleStyle = TextStyle(
        color: Color(0xFFFBFBFF),
        fontFamily: 'SF Pro Rounded',
        fontSize: 12,
        letterSpacing:
            0 /*percentages not used in flutter. defaulting to zero*/,
        fontWeight: FontWeight.w600);

    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          child: Column(
            children: [
              Container(
                height: 20,
                width: 264,
                margin: EdgeInsets.only(top: 22),
                child: Text(storeName,
                    textAlign: TextAlign.left, style: titleStyle),
              ),
              Container(
                height: 42,
                width: 266,
                margin: EdgeInsets.only(top: 5),
                child: Text(
                  storeAddress,
                  textAlign: TextAlign.left,
                  style: subtitleStyle,
                ),
              ),
              Container(
                height: 14,
                width: 266,
                margin: EdgeInsets.only(top: 24),
                child: Text(
                  'Category: $category',
                  textAlign: TextAlign.left,
                  style: subtitleStyle,
                ),
              ),
            ],
          ),
          height: 150,
          width: 317,
          margin: EdgeInsets.only(top: 12),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(0, 29, 74, 0.6000000238418579),
                    offset: Offset(0, 4),
                    blurRadius: 4),
              ],
              borderRadius: BorderRadius.circular(10),
              image: new DecorationImage(
                image: NetworkImage(storeBanner),
                colorFilter: new ColorFilter.mode(
                    Color.fromRGBO(0, 29, 74, 0.6000000238418579),
                    BlendMode.hardLight),
                fit: BoxFit.cover,
              )),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  UserStoreItemsPage(storeDataModel: thestores[index])),
        );
      },
    );
  }

  getStore() {
    FirebaseFirestore.instance.collection('stores').snapshots().listen((data) {
      setState(() {
        thestores =
            List.from(data.docs.map((doc) => StoreDataModel.fromSnapshot(doc)));
      });
    });
  }
}

class StoreDataModel {
  String storeId = "",
      storeName = "",
      storeAddress = "",
      category = "",
      storeBanner = "";

  int maxItems = 0;
  List itemCategories = [], items = [];

  StoreDataModel();
  Map<String, dynamic> toJson() => {
        'storeId': storeId,
        'storeName': storeName,
        'storeAddress': storeAddress,
        'category': category,
        'storeBanner': storeBanner,
        'itemCategories': itemCategories,
        'maxItems': maxItems
      };
  StoreDataModel.fromSnapshot(snapshot)
      : storeId = snapshot.id,
        storeName = snapshot.data()['storeName'],
        storeAddress = snapshot.data()['storeAddress'],
        category = snapshot.data()['category'],
        storeBanner = snapshot.data()['storeBanner'],
        itemCategories = [snapshot.data()['itemCategories']],
        maxItems = snapshot.data()['maxItems'];
}
