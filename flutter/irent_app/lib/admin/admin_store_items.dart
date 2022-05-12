import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:irent_app/admin/admin_edit_item.dart';

import 'admin_add_item.dart';
import 'admin_home.dart';

class AdminStoreItemsPage extends StatefulWidget {
  final StoreDataModel storeDataModel;
  AdminStoreItemsPage({Key? key, required this.storeDataModel})
      : super(key: key);

  @override
  State<AdminStoreItemsPage> createState() => _AdminStoreItemsPageState();
}

class _AdminStoreItemsPageState extends State<AdminStoreItemsPage> {
  final Color white = const Color(0xFFFBFBFF);

  final Color oxford = const Color(0xFF001D4A);

  final Color indigo = const Color(0xFF27476E);

  final Color aliceblue = const Color(0xFF81A4CD);

  final Color iceberg = const Color(0xFFDBE4EE);

  final Color marigold = const Color(0xFFECA400);

  final Color transparent = const Color(0x4DE3E3E3);

  List theitems = [];
  List thecatagories = [];

  final TextEditingController _newcategoryfield = TextEditingController();

  @override
  bool closeTopContainer = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getItems();
    getCategory();
  }

  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.30;

    final double itemHeight = 100;
    final double itemWidth = 120;

    final List items = theitems;
    final List itemCat = thecatagories;

    // final List<CatDataModel> catListData = List.generate(
    //     items.length,
    //     (index) => CatDataModel(
    //           widget.storeDataModel.itemCategories,
    //         ));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.storeDataModel.storeName,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: oxford,
              fontFamily: 'SF_Pro_Rounded',
              fontSize: 25,
              fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            backgroundColor: marigold,
            heroTag: 'add_store',
            onPressed: () {
              if (theitems.length >= widget.storeDataModel.maxItems) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('All the boxes are occupied')));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AdminAddItemPage(
                            storeDataModel: widget.storeDataModel,
                            catDataModel: itemCat)));
                // .then((value) => getItems());
              }
            },
            child: Icon(
              Icons.add,
              size: 30,
            ),
          ),
        ],
      ),
      body: Container(
        color: white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Container(
                          height: 37,
                          decoration: BoxDecoration(
                            color: iceberg,
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0)),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Icon(
                                  Icons.search,
                                  color: Color(0x80001D4A),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, left: 10, bottom: 10, right: 10),
                                child: Text('Search for Items',
                                    style: TextStyle(
                                        color: Color(0x80001D4A),
                                        fontFamily: 'SF_Pro_Rounded',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400)),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    width: 126,
                    height: 30,
                    margin: EdgeInsets.only(left: 30.0, top: 10.0, bottom: 20),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Categories',
                        style: TextStyle(
                            color: oxford,
                            fontFamily: 'SF Pro Rounded',
                            fontSize: 25,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return _addCategoryDialog(context: context);
                            },
                          );
                        },
                        child: Icon(
                          Icons.add,
                          size: 30,
                          color: oxford,
                        )),
                  ),
                ),
              ],
            ),
            Container(
                height: 90,
                padding: EdgeInsets.only(left: 30, right: 30),
                child: _addCategories(context: context, category: itemCat)),
            Expanded(
              flex: 9,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: _productDetailsCard(
                      context: context, itemList: items, itemCat: itemCat)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getCategory() async {
    var selectcategory = await FirebaseFirestore.instance
        .collection('stores')
        .doc(widget.storeDataModel.storeId)
        .snapshots()
        .listen((data) {
      setState(() {
        thecatagories = data.data()!['itemCategories'];
      });
    });
  }

  getItems() {
    FirebaseFirestore.instance
        .collection('stores')
        .doc(widget.storeDataModel.storeId)
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

  Widget _addCategories(
      {required BuildContext context, required List category}) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: category.length,
        itemBuilder: (context, index) {
          for (var cat in category) {
            return Padding(
              padding: EdgeInsets.only(right: 12, bottom: 2, top: 2),
              child: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: Container(
                          decoration: BoxDecoration(
                              // ignore: prefer_const_literals_to_create_immutables
                              boxShadow: [
                                const BoxShadow(
                                    color: Color(0x3327214D),
                                    offset: Offset(2, 3),
                                    blurRadius: 7)
                              ],
                              color: white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(16.0),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(category[index],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'SF Pro Rounded',
                                      color: oxford,
                                      fontWeight: FontWeight.w500,
                                      height: 1,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return _removeDialog(
                                  context: context,
                                  type: 'category',
                                  category_name: category[index]);
                            },
                          );
                        },
                        child: SizedBox(
                          width: 18,
                          height: 18,
                          child: Container(
                            child: Text(
                              '-',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: white, fontSize: 15),
                            ),
                            decoration: BoxDecoration(
                              color: indigo,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          throw 'No Data Found';
        });
  }

  Widget _productDetailsCard(
      {required BuildContext context,
      required List itemList,
      required List itemCat}) {
    // final List<ItemDataModel> itemListData = List.generate(
    //     itemList.length,
    //     (index) => ItemDataModel(
    //           widget.storeDataModel.itemCategories,
    //           '${itemList[index]['id']}',
    //           '${itemList[index]['name']}',
    //           '${itemList[index]['product_category']}',
    //           '${itemList[index]['pricePerhour']}',
    //           '${itemList[index]['quantity']}',
    //           '${itemList[index]['displayPicture']}',
    //         ));
    return Padding(
      padding: const EdgeInsets.all(15),
      child: GridView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: itemList.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            // for (var item in itemListData) {
            return Stack(children: [
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminEditItemPage(
                                    store_id: widget.storeDataModel.storeId,
                                    itemDataModel: theitems[index],
                                    itemCat: itemCat,
                                  )),
                        );
                        // .then((value) => getItems());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(itemList[index].displayPicture),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ))),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return _removeDialog(
                              context: context,
                              type: 'item',
                              item_id: theitems[index].item_id,
                              box_id: theitems[index].box_id);
                        },
                      );
                    },
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: Container(
                        child: Text(
                          '-',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: white, fontSize: 20),
                        ),
                        decoration: BoxDecoration(
                          color: indigo,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ]);
            // }
            // throw 'No Data Found';
          }),
    );
  }

  Widget _addCategoryDialog({required BuildContext context}) {
    return Dialog(
      alignment: Alignment.center,
      backgroundColor: iceberg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 16,
      child: Container(
        height: 190,
        width: 275,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Text(
                'Add Category',
                style: TextStyle(
                    color: oxford,
                    fontFamily: 'SF_Pro_Rounded',
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 25),
                child: Container(
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Container(
                    height: 35,
                    width: 215,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: TextField(
                        controller: _newcategoryfield,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: white)),
                          focusedBorder: InputBorder.none,
                          hintText: 'Category Name',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    height: 30,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            color: oxford,
                            fontFamily: 'SF_Pro_Rounded',
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      ),
                      style: ElevatedButton.styleFrom(
                          elevation: 5,
                          primary: white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(38))),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    width: 100,
                    height: 30,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_newcategoryfield.text != "") {
                          addCategory(_newcategoryfield.text)
                              .then((value) => {
                                    // getCategory(),
                                    Navigator.pop(context)
                                  })
                              .catchError((onError) => {print(onError)});
                        }
                      },
                      child: Text(
                        'Add',
                        style: TextStyle(
                            color: white,
                            fontFamily: 'SF_Pro_Rounded',
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      ),
                      style: ElevatedButton.styleFrom(
                          elevation: 5,
                          primary: indigo,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(38))),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _removeDialog(
      {required BuildContext context,
      required String type,
      String item_id = "",
      String category_name = "",
      String box_id = ""}) {
    return Dialog(
      alignment: Alignment.center,
      backgroundColor: iceberg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 16,
      child: Container(
        height: 105,
        width: 275,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                'Do you want to remove this $type?',
                style: TextStyle(
                    color: indigo,
                    fontFamily: 'SF_Pro_Rounded',
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 30,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'No',
                          style: TextStyle(
                              color: oxford,
                              fontFamily: 'SF_Pro_Rounded',
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ),
                        style: ElevatedButton.styleFrom(
                            elevation: 5,
                            primary: white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(38))),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    SizedBox(
                      width: 100,
                      height: 30,
                      child: ElevatedButton(
                        onPressed: () {
                          if (type == "item" && item_id != "") {
                            deleteItem(item_id, box_id)
                                .then((value) => {
                                      // getItems(),
                                      Navigator.pop(context)
                                    })
                                .catchError((onError) => {print(onError)});
                          } else if (type == 'category' &&
                              category_name != "") {
                            deleteCategory(category_name)
                                .then((value) => {
                                      // getCategory(),
                                      Navigator.pop(context)
                                    })
                                .catchError((onError) => {print(onError)});
                          }
                        },
                        child: Text(
                          'Yes',
                          style: TextStyle(
                              color: white,
                              fontFamily: 'SF_Pro_Rounded',
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ),
                        style: ElevatedButton.styleFrom(
                            elevation: 5,
                            primary: indigo,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(38))),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> deleteItem(item_id, box_id) {
    var emptybox = FirebaseFirestore.instance
        .collection('stores')
        .doc(widget.storeDataModel.storeId)
        .collection("boxes")
        .doc(box_id)
        .update({
      'empty': true,
      'item_id': "",
    });
    CollectionReference selectitem = FirebaseFirestore.instance
        .collection('stores')
        .doc(widget.storeDataModel.storeId)
        .collection('items');
    return selectitem.doc(item_id).delete();
  }

  Future<void> addCategory(category_name) {
    DocumentReference selectcategory = FirebaseFirestore.instance
        .collection('stores')
        .doc(widget.storeDataModel.storeId);
    return selectcategory.update({
      "itemCategories": FieldValue.arrayUnion([category_name])
    });
  }

  Future<void> deleteCategory(category_name) {
    DocumentReference selectcategory = FirebaseFirestore.instance
        .collection('stores')
        .doc(widget.storeDataModel.storeId);
    return selectcategory.update({
      "itemCategories": FieldValue.arrayRemove([category_name])
    });
  }
}

// class ItemDataModel {
//   final List itemCategories;
//   final String id,
//       name,
//       productCategory,
//       pricePerHour,
//       quantity,
//       displayPicture;

//   ItemDataModel(this.itemCategories, this.id, this.name, this.productCategory,
//       this.pricePerHour, this.quantity, this.displayPicture);
// }

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

class CatDataModel {
  final List itemCategories;

  CatDataModel(this.itemCategories);
}
