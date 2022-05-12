// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:irent_app/admin/admin_constants.dart';
import 'package:irent_app/switch_nav.dart';
import 'admin_home.dart';
import 'admin_constants.dart';
import 'admin_store_items.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uuid/uuid.dart';

class AdminAddItemPage extends StatefulWidget {
  final catDataModel;
  final StoreDataModel storeDataModel;
  const AdminAddItemPage(
      {Key? key, required this.catDataModel, required this.storeDataModel})
      : super(key: key);
  @override
  _AdminAddItemPageState createState() => _AdminAddItemPageState();
}

class _AdminAddItemPageState extends State<AdminAddItemPage> {
  final Color white = const Color(0xFFFBFBFF);
  final Color oxford = const Color(0xFF001D4A);
  final Color aliceblue = const Color(0xFF81A4CD);
  final Color iceberg = const Color(0xFFDBE4EE);
  final Color marigold = const Color(0xFFECA400);
  final Color transparent = const Color(0x4DE3E3E3);

  final TextStyle titleStyle = const TextStyle(
      fontFamily: 'SF_Pro_Rounded',
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: Color(0xFF001D4A));

  final TextStyle fieldStyle = const TextStyle(
      fontFamily: 'SF_Pro_Rounded',
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: Color(0xFF001D4A));
  var dropdownValue;

  final TextEditingController _productField = TextEditingController();
  final TextEditingController _priceField = TextEditingController();
  final TextEditingController _qtyField = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File? _myImage;
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: white,
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: Column(children: [
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
                            'Add Item',
                            style: TextStyle(
                                color: oxford,
                                fontFamily: 'SF_Pro_Rounded',
                                fontSize: 25,
                                fontWeight: FontWeight.w500),
                          ),
                          elevation: 0,
                          leading: SizedBox(),
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
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _inputFields(field: 'Name', controller: _productField),
                        _dropDown(
                            context: context,
                            items: widget.catDataModel.cast<String>(),
                            field: 'Category'),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text('Price', style: titleStyle),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: iceberg,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            child: Text('\$'),
                                          )),
                                      Expanded(
                                        flex: 7,
                                        child: SingleChildScrollView(
                                          child: Container(
                                            height: 40,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, bottom: 8),
                                              child: TextFormField(
                                                controller: _priceField,
                                                maxLines: 1,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none),
                                                style: fieldStyle,
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: Text('/ hour'),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child:
                                  Text('Available Quantity', style: titleStyle),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    color: iceberg,
                                  ),
                                  child: SingleChildScrollView(
                                    child: Container(
                                      height: 40,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, bottom: 7),
                                        child: TextFormField(
                                            controller: _qtyField,
                                            maxLines: 1,
                                            decoration: InputDecoration(
                                                border: InputBorder.none),
                                            style: fieldStyle,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ]),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // _inputFields(
                        //     field: 'Available Quantity', controller: _qtyField),
                        _addBanner(field: 'Display Picture')
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 160,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                              color: oxford,
                              fontFamily: 'SF_Pro_Rounded',
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(38))),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 160,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_productField.text == "" ||
                              dropdownValue == "" ||
                              _priceField.text == "" ||
                              _qtyField.text == "" ||
                              _myImage == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('All field required!')));
                          } else {
                            AddItem(_myImage)
                                .then((value) => Navigator.pop(context))
                                .catchError(
                                    (onError) => {print("There is an error")});
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
                            primary: marigold,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(38))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputFields(
      {required String field, required TextEditingController controller}) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(field, style: titleStyle),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: iceberg,
              ),
              child: SingleChildScrollView(
                child: Container(
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 7),
                    child: TextFormField(
                      controller: controller,
                      maxLines: 1,
                      decoration: InputDecoration(border: InputBorder.none),
                      style: fieldStyle,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _dropDown(
      {required BuildContext context,
      required List<String> items,
      required String field}) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(field, style: titleStyle),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: iceberg,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: const Icon(Icons.keyboard_arrow_down_sharp),
                  ),
                  iconSize: 28,
                  iconEnabledColor: Color(0xFF001D4A),
                  elevation: 16,
                  style: fieldStyle,
                  hint: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text('Select', style: fieldStyle),
                  ),
                  items: items.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  value: dropdownValue,
                  isDense: true,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _addBanner({required String field}) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          flex: 1,
          child: Text(
            field,
            style: titleStyle,
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              InkWell(
                onTap: () async {
                  selectedImage = await selectImage();
                  if (selectedImage != null) {
                    setState(() {
                      _myImage = selectedImage as File;
                    });
                  }
                },
                child: Container(
                  width: 135,
                  height: 135,
                  decoration: _myImage == null
                      ? BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: iceberg,
                        )
                      : BoxDecoration(
                          image: DecorationImage(
                              image:
                                  FileImage(_myImage as File) as ImageProvider),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: iceberg,
                        ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Align(
                      alignment: Alignment.center,
                      child: _myImage == null
                          ? Text(
                              '+ Add Image',
                              style: fieldStyle,
                            )
                          : Container(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Future AddItem(_myImage) async {
    String fileID = Uuid().v4();
    var emptybox = await FirebaseFirestore.instance
        .collection('stores')
        .doc(widget.storeDataModel.storeId)
        .collection("boxes")
        .where('empty', isEqualTo: true)
        .limit(1)
        .get();

    List theemptybox =
        List.from(emptybox.docs.map((doc) => BoxesDataModel.fromSnapshot(doc)));
    if (theemptybox.isNotEmpty) {
      final firebase_storage.Reference firebaseStorageRef = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child("items/$fileID"); //i is the name of the image
      firebase_storage.UploadTask uploadTask =
          firebaseStorageRef.putFile(_myImage);
      try {
        firebase_storage.TaskSnapshot storageSnapshot = await uploadTask;
        var downloadUrl = await storageSnapshot.ref.getDownloadURL();
        final String url = downloadUrl.toString();
        FirebaseFirestore.instance
            .collection('stores')
            .doc(widget.storeDataModel.storeId)
            .collection("items")
            .doc(fileID)
            .set({
          'displayPicture': url,
          'name': _productField.text,
          'pricePerhour': _priceField.text,
          'product_category': dropdownValue,
          'quantity': _qtyField.text,
          'box_number': theemptybox[0].box_number,
          'box_id': theemptybox[0].box_id,
          'storeName': widget.storeDataModel.storeName,
          'storeId': widget.storeDataModel.storeId,
        });
        //You might want to set this as the _auth.currentUser().photourl

      } on FirebaseException catch (e) {
        print(uploadTask.snapshot);
      }
      FirebaseFirestore.instance
          .collection('stores')
          .doc(widget.storeDataModel.storeId)
          .collection("boxes")
          .doc(theemptybox[0].box_id)
          .update({
        'empty': false,
        'item_id': fileID,
      });
    }
  }

  Future selectImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 1500,
      maxWidth: 1500,
    );
    if (image != null) {
      return File(image.path);
    }
    return null;
  }
}

class BoxesDataModel {
  bool empty = false;
  String item_id = "", box_id = "";
  int box_number = 0;

  BoxesDataModel();
  Map<String, dynamic> toJson() => {
        'box_id': box_id,
        'empty': empty,
        'item_id': item_id,
        'box_number': box_number,
      };
  BoxesDataModel.fromSnapshot(snapshot)
      : box_id = snapshot.id,
        empty = snapshot.data()['empty'],
        item_id = snapshot.data()['item_id'],
        box_number = snapshot.data()['box_number'];
}
