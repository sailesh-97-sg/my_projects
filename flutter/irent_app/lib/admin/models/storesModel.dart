class StoreModel {
  static const CATEGORY = "category";
  static const ITEM_CATEGORIES = "itemCategories";
  static const ITEMS = "items";
  static const STOREADDRESS = "storeAddress";
  static const STOREBANNER = "storeBanner";
  static const STORENAME = "storeName";

  String? category;
  String? itemcategories;
  String? storeaddress;
  List? items;
  String? storebanner;
  String? storename;

  StoreModel(
      {this.category,
      this.itemcategories,
      this.storeaddress,
      this.items,
      this.storebanner,
      this.storename});

  StoreModel.fromMap(Map<String, dynamic> data) {
    category = data[CATEGORY];
    itemcategories = data[ITEM_CATEGORIES];
    storeaddress = data[STOREADDRESS];
    items = data[ITEMS];
    storebanner = data[STOREBANNER];
    storename = data[STORENAME];
  }
}
