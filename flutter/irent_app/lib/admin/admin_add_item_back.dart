// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:irent_app/admin/admin_constants.dart';
import 'package:irent_app/switch_nav.dart';
import 'admin_home.dart';
import 'admin_constants.dart';
import 'admin_store_items.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uuid/uuid.dart';

class AdminAddItemPageBack extends StatefulWidget {
  final String theIndex;

  const AdminAddItemPageBack({Key? key, required this.theIndex})
      : super(key: key);
  @override
  _AdminAddItemPageBackState createState() => _AdminAddItemPageBackState();
}

class _AdminAddItemPageBackState extends State<AdminAddItemPageBack> {
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

  final TextEditingController _productField = TextEditingController();
  final TextEditingController _categoryField = TextEditingController();
  final TextEditingController _priceField = TextEditingController();
  final TextEditingController _qtyField = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File? _myImage;
  File? selectedImage;

  List<String> categoryitems = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: white,
      body: Stack(
        children: [
          Column(children: [
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
            Form(
              key: _formKey,
              child: Expanded(
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
                            items: categoryitems,
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
                        _inputFields(
                            field: 'Available Quantity', controller: _qtyField),
                        _addBanner(field: 'Display Picture')
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]),
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
                          if (_formKey.currentState!.validate()) {
                            AddItem(_myImage);
                            // FirebaseFirestore.instance
                            //     .collection('stores')
                            //     .doc(widget.theIndex)
                            //     .collection("items")
                            //     .add({
                            //   'displayPicture':
                            //       'images/Image_mariokartdeluxe.jpg',
                            //   'name': _productField.text,
                            //   'pricePerhour': _priceField.text,
                            //   'product_category': _categoryField.text,
                            //   'quantity': _qtyField.text,
                            // });
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
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
    var dropdownValue;
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
              // child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                validator: (value) => value == null ? 'field required' : null,
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
              // ),
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
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: _myImage == null
                            ? AssetImage(
                                'images/cross-bg-cropped-2.png',
                              )
                            : FileImage(_myImage as File) as ImageProvider),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: iceberg,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '+ Add Image',
                        style: fieldStyle,
                      ),
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

  @override
  void initState() {
    CollectionReference storeCollection =
        FirebaseFirestore.instance.collection('stores');
    storeCollection.doc(widget.theIndex).get().then((DocumentSnapshot datas) {
      try {
        List<String> items =
            List<String>.from(datas.get(FieldPath(['itemCategories'])));
        setState(() {
          categoryitems = items;
        });
      } on StateError catch (e) {
        print('No nested field exists!');
      }
    });
    super.initState();
  }

  Future AddItem(_myImage) async {
    String fileID = Uuid().v4();

    final firebase_storage.Reference firebaseStorageRef = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child("images/$fileID"); //i is the name of the image
    firebase_storage.UploadTask uploadTask =
        firebaseStorageRef.putFile(_myImage);
    try {
      firebase_storage.TaskSnapshot storageSnapshot = await uploadTask;
      var downloadUrl = await storageSnapshot.ref.getDownloadURL();
      final String url = downloadUrl.toString();
      FirebaseFirestore.instance
          .collection('stores')
          .doc(widget.theIndex)
          .collection("items")
          .doc(fileID)
          .set({
        'displayPicture': url,
        'name': _productField.text,
        'pricePerhour': _priceField.text,
        'product_category': _categoryField.text,
        'quantity': _qtyField.text,
      });
      //You might want to set this as the _auth.currentUser().photourl

    } on FirebaseException catch (e) {
      print(uploadTask.snapshot);
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
