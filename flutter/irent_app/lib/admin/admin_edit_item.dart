// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:irent_app/admin/admin_qr_page.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uuid/uuid.dart';
import 'admin_home.dart';
import 'admin_store_items.dart';

enum FeedbackType { report, suggestion }

class AdminEditItemPage extends StatefulWidget {
  final store_id;
  final ItemDataModel itemDataModel;
  final itemCat;
  const AdminEditItemPage(
      {Key? key,
      required this.store_id,
      required this.itemDataModel,
      required this.itemCat})
      : super(key: key);

  @override
  _AdminEditItemPageState createState() => _AdminEditItemPageState();
}

class _AdminEditItemPageState extends State<AdminEditItemPage> {
  final Color white = const Color(0xFFFBFBFF);
  final Color oxford = const Color(0xFF001D4A);
  final Color indigo = const Color(0xFF27476E);
  final Color aliceblue = const Color(0xFF81A4CD);
  final Color iceberg = const Color(0xFFDBE4EE);
  final Color marigold = const Color(0xFFECA400);
  final Color transparent = const Color(0x4DE3E3E3);

  final TextStyle titleStyle = const TextStyle(
      fontFamily: 'SF_Pro_Rounded',
      fontSize: 16,
      fontWeight: FontWeight.w600,
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
                            'Edit Item',
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
                            field: 'Category',
                            itemCat: widget.itemCat.cast<String>()),
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
                                                  inputFormatters: <
                                                      TextInputFormatter>[
                                                    FilteringTextInputFormatter
                                                        .digitsOnly
                                                  ]),
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
                        _addBanner(
                            field: 'Display Picture',
                            displayPicture:
                                widget.itemDataModel.displayPicture),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text('Box Number', style: titleStyle),
                            ),
                            Expanded(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AdminQRPage(
                                                store_id: widget.store_id,
                                                box_number: widget
                                                    .itemDataModel.box_number,
                                                item_id: widget
                                                    .itemDataModel.item_id)));
                                  },
                                  child: Text(
                                    'Press here to get QR Code',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: marigold,
                                        fontFamily: 'SF_Pro_Rounded',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
                              dropdownValue == null ||
                              _priceField.text == "" ||
                              _qtyField.text == "") {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('All field required!')));
                          } else {
                            EditItem(_myImage, widget.itemDataModel.item_id)
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
      required String field,
      required List<String> itemCat}) {
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
                  value: dropdownValue,
                  isDense: true,
                  hint: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text('Select', style: fieldStyle),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: itemCat.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _addBanner({required String field, required String displayPicture}) {
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
                              ? NetworkImage(displayPicture)
                              : FileImage(_myImage as File) as ImageProvider,
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: iceberg,
                    )),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Future EditItem(_myImage, item_id) async {
    if (_myImage == null) {
      FirebaseFirestore.instance
          .collection('stores')
          .doc(widget.store_id)
          .collection("items")
          .doc(item_id)
          .update({
        'name': _productField.text,
        'pricePerhour': _priceField.text,
        'product_category': dropdownValue,
        'quantity': _qtyField.text,
      });
    } else {
      final firebase_storage.Reference firebaseStorageRef = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child("images/$item_id"); //i is the name of the image
      firebase_storage.UploadTask uploadTask =
          firebaseStorageRef.putFile(_myImage);
      try {
        firebase_storage.TaskSnapshot storageSnapshot = await uploadTask;
        var downloadUrl = await storageSnapshot.ref.getDownloadURL();
        final String url = downloadUrl.toString();
        FirebaseFirestore.instance
            .collection('stores')
            .doc(widget.store_id)
            .collection("items")
            .doc(item_id)
            .update({
          'displayPicture': url,
          'name': _productField.text,
          'pricePerhour': _priceField.text,
          'product_category': dropdownValue,
          'quantity': _qtyField.text,
        });
        //You might want to set this as the _auth.currentUser().photourl

      } on FirebaseException catch (e) {
        print(uploadTask.snapshot);
      }
    }
  }

  @override
  void initState() {
    _productField.text = widget.itemDataModel.name;
    _priceField.text = widget.itemDataModel.pricePerhour;
    _qtyField.text = widget.itemDataModel.quantity;
    if (widget.itemCat.contains(widget.itemDataModel.product_category)) {
      dropdownValue = widget.itemDataModel.product_category;
    } else {
      // dropdownValue = "";
    }
    super.initState();
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
