import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

final now = "2022-03-16 12:00:00";

var notificationData = [
  {
    "storeName": "UROC",
    "itemName": "Overcooked",
    "receiveTime": "2022-03-16 11:55:00",
    "ticketNumber": 59,
    "displayPicture": 'images/Image_uroc.png'
  },
  {
    "storeName": "CISS",
    "itemName": "Breadboard",
    "receiveTime": "2022-03-16 11:45:00",
    "ticketNumber": 43,
    "displayPicture": 'images/Image_ciss.png'
  },
  {
    "storeName": "UROC",
    "itemName": "Mario Kart Deluxe",
    "receiveTime": "2022-03-16 11:40:00",
    "ticketNumber": 28,
    "displayPicture": 'images/Image_uroc.png'
  },
  {
    "storeName": "CISS",
    "itemName": "Jumper Wire",
    "receiveTime": "2022-03-16 11:30:00",
    "ticketNumber": 7,
    "displayPicture": 'images/Image_ciss.png'
  },
];

var categories = <String>['Recreation', 'Laboratory', 'Inventory'];

var userFeedbackData = [
  {
    "user": 'JOHN003@e.ntu.edu.sg',
    "itemName": "Overcooked",
    "submissionTime": "2022-03-16, 11:55:00",
    "ticketNumber": 59,
    "displayPicture": 'images/Image_overcooked.jpg',
    "feedbackType": 'Fault Report',
    "comments": 'CD is scratched. Cannot be played.'
  },
  {
    "user": 'MICH0090@e.ntu.edu.sg',
    "itemName": "Wii",
    "submissionTime": "2022-03-20, 15:30:00",
    "ticketNumber": 28,
    "displayPicture": 'images/wii_remote.png',
    "feedbackType": 'Fault Report',
    "comments": '\'A\' button is faulty. Cannot be pressed.'
  }
];

var alertData = [
  {
    "user": 'JOHN003@e.ntu.edu.sg',
    "itemName": "Overcooked",
    "returnTime": "2022-03-16, 11:55:00",
    "ticketNumber": 59,
    "displayPicture": 'images/wii_remote.png',
    "prevImage": 'images/wii_prevImage.png',
    "currentImage": 'images/wii_empty.png',
  },
  {
    "user": 'JOHN003@e.ntu.edu.sg',
    "itemName": "Overcooked",
    "returnTime": "2022-03-16, 11:55:00",
    "ticketNumber": 59,
    "displayPicture": 'images/wii_remote.png',
    "prevImage": 'images/wii_prevImage.png',
    "currentImage": 'images/wii_empty.png',
  }
];
var transactionData = [
  {
    "ticketNumber": 168,
    "paymentDate": "22-03-2022",
    "totalAmount": 12.5,
  },
  {
    "ticketNumber": 156,
    "paymentDate": "21-03-2022",
    "totalAmount": 6.15,
  },
  {
    "ticketNumber": 137,
    "paymentDate": "20-03-2022",
    "totalAmount": 3,
  },
  {
    "ticketNumber": 99,
    "paymentDate": "19-03-2022",
    "totalAmount": 7.5,
  },
  {
    "ticketNumber": 74,
    "paymentDate": "18-03-2022",
    "totalAmount": 5,
  },
  {
    "ticketNumber": 59,
    "paymentDate": "17-03-2022",
    "totalAmount": 2.5,
  },
  {
    "ticketNumber": 28,
    "paymentDate": "16-03-2022",
    "totalAmount": 10,
  }
];
var bookingsData = [
  {
    "user": 'MICH0090@e.ntu.edu.sg',
    "name": "Overcooked",
    "qty": 1,
    "price": 5,
    "collectDate": DateFormat.yMd().format(DateTime(2022, 3, 19)),
    "returnDate": DateFormat.yMd().format(DateTime.now()),
    "collectTime": DateFormat.jm().format(DateTime.now()),
    "returnTime": DateFormat.jm().format(DateTime.now()),
    "ticketNumber": 7,
    "displayPicture": 'images/Image_overcooked.jpg',
    "itemLoc": 'Box',
    "returned": 'Yes',
    "imgCapture": 'images/overcooked_cd.jpeg'
  },
  {
    "user": 'STEP0003@e.ntu.edu.sg',
    "name": "Mario Kart Deluxe",
    "qty": 2,
    "price": 10,
    "collectDate": DateFormat.yMd().format(DateTime.now()),
    "returnDate": '-',
    "collectTime": DateFormat.jm().format(DateTime.now()),
    "returnTime": '-',
    "ticketNumber": 28,
    "displayPicture": 'images/Image_mariokartdeluxe.jpg',
    "itemLoc": 'User',
    "returned": 'No',
    "imgCapture": 'images/mario_kart_cd.jpeg'
  },
  {
    "user": 'JOHN0120@e.ntu.edu.sg',
    "name": "FIFA 22",
    "qty": 3,
    "price": 2.5,
    "collectDate": DateFormat.yMd().format(DateTime.now()),
    "returnDate": '-',
    "collectTime": DateFormat.jm().format(DateTime.now()),
    "returnTime": '-',
    "ticketNumber": 9,
    "displayPicture": 'images/Image_fifa22.jpeg',
    "itemLoc": 'Box',
    "returned": 'No',
    "imgCapture": 'images/fifa_cd.jpeg'
  },
];

var stores = [
  {
    "storeName": "UR0C @ Student Activity Centre",
    "storeAddress":
        "North Spine, NS3-01-03, 50 Nanyang Ave, Block N3.1, Singapore 639798",
    "category": "Recreational Games",
    "storeBanner": 'images/uroc.jpeg',
    'itemCategories': [
      'Consoles',
      'CD Games',
      'Board Games',
      'Card Games',
      'Spaces'
    ],
    'items': [
      {
        "id": 'p1',
        "name": "Mario Kart Deluxe",
        "product_category": "Console Game",
        "pricePerhour": "1",
        "quantity": "3",
        "displayPicture": 'images/Image_mariokartdeluxe.jpg'
      },
      {
        "id": 'p2',
        "name": "Super Mario",
        "product_category": "Console Game",
        "pricePerhour": "1",
        "quantity": "5",
        "displayPicture": 'images/Image_supermario.jfif'
      },
      {
        "id": 'p3',
        "name": "Overcooked",
        "product_category": "Console Game",
        "pricePerhour": "1",
        "quantity": "2",
        "displayPicture": 'images/Image_overcooked.jpg'
      },
      {
        "id": 'p4',
        "name": "Fifa 22",
        "product_category": "Console Game",
        "pricePerhour": "1",
        "quantity": "3",
        "displayPicture": 'images/Image_fifa22.jpeg'
      },
      {
        "id": 'p5',
        "name": "Madden 18",
        "product_category": "Console Game",
        "pricePerhour": "1",
        "quantity": "1",
        "displayPicture": 'images/Image_madden18.jpg'
      }
    ]
  },
  {
    "storeName": "Centre for Information Sciences and Systems (CISS)",
    "storeAddress": "50 Nanyang Ave S2-B4b-05, Singapore 639798",
    "category": "EEE Laboratories",
    "storeBanner": 'images/Image_ciss.png',
    'itemCategories': ['Tools', 'Cables', 'Components', 'Breadboard', 'Spaces'],
    'items': [
      {
        "id": 'p1',
        "name": "Breadboard",
        "product_category": "Console Game",
        "pricePerhour": "1",
        "quantity": "3",
        "displayPicture": 'images/ciss_lab/breadboard.jpeg'
      },
      {
        "id": 'p2',
        "name": "Jumper Wires",
        "product_category": "Console Game",
        "pricePerhour": "1",
        "quantity": "5",
        "displayPicture": 'images/ciss_lab/jumper_wires.webp'
      },
      {
        "id": 'p3',
        "name": "Multimeter",
        "product_category": "Console Game",
        "pricePerhour": "1",
        "quantity": "2",
        "displayPicture": 'images/ciss_lab/multimeter.jpeg'
      },
      {
        "id": 'p4',
        "name": "Screwdriver",
        "product_category": "Console Game",
        "pricePerhour": "1",
        "quantity": "3",
        "displayPicture": 'images/ciss_lab/screwdriver.webp'
      },
      {
        "id": 'p5',
        "name": "Wafer",
        "product_category": "Console Game",
        "pricePerhour": "1",
        "quantity": "1",
        "displayPicture": 'images/ciss_lab/wafer.jpeg'
      }
    ]
  },
];

var stores2 = FirebaseFirestore.instance
    .collection('stores')
    .get()
    .then((QuerySnapshot querySnapshot) {
  // print(querySnapshot.docs[0]['storeName']);
  // querySnapshot.docs.map()
  List newstores = [];
  querySnapshot.docs.forEach((documents) {
    // print(documents['storeName']);
    // newstores.map((e) => {
    //       e.category = documents['storeName'],
    //       e.itemCategories = documents['itemCategories'],
    //       e.items = documents['items'],
    //       e.storeAddress = documents['storeAddress'],
    //       e.storeBanner = documents['storeBanner'],
    //       e.storeName = documents['storeName'],
    //     });
    final myStore = {
      'category': documents['category'],
      'itemCategories': documents['itemCategories'],
      'items': documents['items'],
      'storeAddress': documents['storeAddress'],
      'storeBanner': documents['storeBanner'],
      'storeName': documents['storeName'],
    };

    newstores.add(myStore);

    print(myStore);
  });
  return newstores.toList();
});
final Map adminQR = {
  'username': 'admin',
  'key':
      'UhYG2zeQjX4XQwoH/N3zm7JJVr2PNSx9CngexOBQIvduTSVL6FJmETCmUYb5oItUh6J3IKL3xYb/YoMOixkG44aU0+CH/BJIt14ysa9Mkt+l0wRYgw6fFMXgDIuqqKUZGO/86qK6F5/GyEieaZFCkoNyc96ax0IbwdeTG1nF7PvAn0xepH2m8/BusjrVsc8Iv5etRqzyvFQhh1hWLYC+up26L0xqjvQ14KeCzwBGeEKJ5G63jOlrYS2b0+8YaDv95vL23q0X5XUtqS2P14AlU6wMxPQgJgfevnPxMmsfphCgMW/jLYfZ8L5AUhb7s+ZwqdHdr1cxGdg56JxQYEpPOg==',
  'status': '0',
  'store': '0',
  'box': '1',
};
