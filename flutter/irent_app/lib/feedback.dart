// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:irent_app/switch_nav.dart';
import 'homepage.dart';
import 'constants.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

enum FeedbackType { report, suggestion }

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController _typeField = TextEditingController();
  final TextEditingController _messageField = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Color white = const Color(0xFFFBFBFF);
  final Color oxford = const Color(0xFF001D4A);
  final Color aliceblue = const Color(0xFF81A4CD);
  final Color iceberg = const Color(0xFFDBE4EE);
  final Color marigold = const Color(0xFFECA400);
  final Color transparent = const Color(0x4DE3E3E3);

  FeedbackType? _feedbackType = FeedbackType.report;

  bool? _success;
  String? _userEmail;

  List thestores = [];
  List theitems = [];
  var dropdownValueStore;
  var dropdownValueItem;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getStore();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: white,
      body: Column(children: [
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
                    'images/cross-bg-cropped-2.png',
                  ),
                ),
                Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    centerTitle: true,
                    title: Text(
                      'Feedback',
                      style: TextStyle(
                          color: oxford,
                          fontFamily: 'SF_Pro_Rounded',
                          fontSize: 25,
                          fontWeight: FontWeight.w500),
                    ),
                    elevation: 0,
                    leading: Row(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.05),
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
          flex: 6,
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(25),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "What is your feedback about?",
                          style: TextStyle(
                              fontFamily: 'SF_Pro_Rounded',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: oxford),
                        ),
                        SizedBox(height: 10),
                        _radioButton(
                            option: 'Fault Report', value: FeedbackType.report),
                        _radioButton(
                            option: 'Suggestion',
                            value: FeedbackType.suggestion),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Shop",
                                  style: TextStyle(
                                      fontFamily: 'SF_Pro_Rounded',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: oxford),
                                ),
                                _dropDownStores(
                                    context: context,
                                    items: thestores
                                        .map((item) => item.storeName)
                                        .toList()),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Item",
                                  style: TextStyle(
                                      fontFamily: 'SF_Pro_Rounded',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: oxford),
                                ),
                                _dropDownItems(
                                    context: context,
                                    items: theitems
                                        .map((item) => item.name)
                                        .toList()),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Comments",
                      style: TextStyle(
                          fontFamily: 'SF_Pro_Rounded',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: oxford),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: iceberg,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: SingleChildScrollView(
                            child: TextField(
                                controller: _messageField,
                                keyboardType: TextInputType.multiline,
                                minLines: 10,
                                maxLines: 10,
                                decoration: InputDecoration.collapsed(
                                    hintText: 'Type here')),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: 160,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_messageField.text.isNotEmpty &&
                                dropdownValueStore != null &&
                                dropdownValueItem != null) {
                              sendFeedback().then((value) => {
                                    Navigator.pop(context),
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Thank you for your feedback.')))
                                  });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('All field are required')));
                            }
                            ;
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _radioButton({required String option, required FeedbackType value}) {
    return RadioListTile<FeedbackType>(
      title: Text(
        option,
        style: TextStyle(
            fontFamily: 'SF_Pro_Rounded',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: oxford),
      ),
      value: value,
      groupValue: _feedbackType,
      onChanged: (FeedbackType? value) {
        setState(() {
          _feedbackType = value;
        });
      },
      contentPadding: EdgeInsets.all(0),
      activeColor: oxford,
    );
  }

  Widget _dropDownStores({required BuildContext context, required List items}) {
    // String dropdownValueStore = items[0];
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: iceberg,
        ),
        child: DropdownButton<String>(
          isExpanded: true,
          value: dropdownValueStore,
          icon: Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: const Icon(Icons.keyboard_arrow_down_sharp),
          ),
          iconSize: 28,
          iconEnabledColor: Color(0xFF001D4A),
          elevation: 16,
          style: const TextStyle(color: Color(0xFF001D4A)),
          underline: Container(
            height: 2,
            color: Color(0xFFDBE4EE),
          ),
          hint: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text('Select'),
          ),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValueStore = newValue!;
            });
            // getItems();
            dropdownValueItem = null;
          },
          items: items.map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(value),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _dropDownItems({required BuildContext context, required List items}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: iceberg,
        ),
        child: DropdownButton<String>(
          isExpanded: true,
          value: dropdownValueItem,
          icon: Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: const Icon(Icons.keyboard_arrow_down_sharp),
          ),
          iconSize: 28,
          iconEnabledColor: Color(0xFF001D4A),
          elevation: 16,
          style: const TextStyle(color: Color(0xFF001D4A)),
          underline: Container(
            height: 2,
            color: Color(0xFFDBE4EE),
          ),
          hint: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text('Select'),
          ),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValueItem = newValue!;
            });
          },
          items: items.map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(value),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  getStore() {
    FirebaseFirestore.instance.collection('stores').snapshots().listen((data) {
      setState(() {
        thestores =
            List.from(data.docs.map((doc) => StoreDataModel.fromSnapshot(doc)));
        // storeData = newstores;
      });
    });
  }

  getItems() {
    FirebaseFirestore.instance
        .collection('stores')
        .doc(thestores
            .where((element) => element.storeName == dropdownValueStore)
            .toList()[0]
            .storeId
            .toString())
        .collection('items')
        .snapshots()
        .listen((data) {
      setState(() {
        theitems =
            List.from(data.docs.map((doc) => ItemDataModel.fromSnapshot(doc)));
        // storeData = newstores;
      });
    });
  }

  Future sendFeedback() async {
    var transactions =
        await FirebaseFirestore.instance.collection('feedback').get();
    var count = transactions.docs.length + 1;
    var data = FirebaseFirestore.instance.collection('feedback');
    var item = theitems
        .where((element) => element.name == dropdownValueItem)
        .toList()[0];
    var type;
    if (_feedbackType!.index == 0) {
      type = "fault";
    } else if (_feedbackType!.index == 1) {
      type = "suggestion";
    }
    return data.doc(count.toString()).set({
      "ticketNumber": count,
      "submissionTime": DateTime.now(),
      "feedbackType": type,
      "shop": dropdownValueStore,
      "itemName": dropdownValueItem,
      "item_id": item.item_id,
      "comment": _messageField.text,
      "user": FirebaseAuth.instance.currentUser!.email,
      "displayPicture": item.displayPicture,
      "resolved": false
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

class ItemDataModel {
  String displayPicture = "",
      name = "",
      pricePerhour = "",
      product_category = "",
      quantity = "",
      item_id = "",
      box_id = "",
      storeName = "",
      storeId = "";
  int box_number = 0;
  // item_id = "";

  ItemDataModel();
  Map<String, dynamic> toJson() => {
        'displayPicture': displayPicture,
        'name': name,
        'pricePerhour': pricePerhour,
        'product_category': product_category,
        'quantity': quantity,
        'item_id': item_id,
        'box_id': box_id,
        'box_number': box_number,
        'storeName': storeName,
        'storeId': storeId,
        // 'item_id': item_id,
      };
  ItemDataModel.fromSnapshot(snapshot)
      : displayPicture = snapshot.data()['displayPicture'],
        name = snapshot.data()['name'],
        pricePerhour = snapshot.data()['pricePerhour'],
        product_category = snapshot.data()['product_category'],
        quantity = snapshot.data()['quantity'],
        item_id = snapshot.id,
        box_id = snapshot.data()['box_id'],
        box_number = snapshot.data()['box_number'],
        storeName = snapshot.data()['storeName'],
        storeId = snapshot.data()['storeId'];
}
