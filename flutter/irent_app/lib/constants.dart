import 'package:intl/intl.dart';

const String whatIsiRent =
    """Simple and convenient - the first ever automated borrowing system that integrates all loaning and returning of items at NTU. Plan ahead and book items with a mere tap, then proceeed ahead to our iRent machines spread across various locations to collect. Even better, cashless payments are supported for all services.""";

const String policy_1 =
    """A deposit of \$5 are required to be made prior to make the first booking. For subsequent bookings, a minimum \$2 deposit is required.""";

const String policy_2 =
    """A fine will immediately be deducted from the user's wallet under the following circumstances upon returning of each item:
1. \$0.5 fine for every damage found on the item
2. \$1 fine for every 15 minutes of late return
3. Purchasing amount for every missing or mismatched item""";

const String policy_3 =
    """The remaining amount in the user's wallet will be transferred to his linked bank account upon uninstallment of the application.""";

var shops = <String>['Select', 'UROC', 'CISS Lab', 'iHub', 'EEE Inventory'];
var items_UROC = <String>[
  'Select',
  'Mario Kart 8 Deluxe',
  'Wii Game Console',
  'Monopoly Cards',
  'Ping Pong Racket'
];

var historyData = [
  {
    "name": "Overcooked",
    "qty": 1,
    "price": 1,
    "pricePerhour": "1",
    "collectDate": DateFormat.yMd().format(DateTime.now()),
    "returnDate": DateFormat.yMd().format(DateTime.now()),
    "collectTime": DateFormat.jm().format(DateTime.now()),
    "returnTime": DateFormat.jm().format(DateTime.now()),
    "ticketNumber": 7,
    "displayPicture": 'images/Image_overcooked.jpg'
  },
  {
    "name": "Mario Kart Deluxe",
    "qty": 2,
    "price": 2,
    "pricePerhour": "1",
    "collectDate": DateFormat.yMd().format(DateTime.now()),
    "returnDate": DateFormat.yMd().format(DateTime.now()),
    "collectTime": DateFormat.jm().format(DateTime.now()),
    "returnTime": DateFormat.jm().format(DateTime.now()),
    "ticketNumber": 28,
    "displayPicture": 'images/Image_mariokartdeluxe.jpg'
  },
  {
    "name": "FIFA 22",
    "qty": 2,
    "price": 2,
    "pricePerhour": "1",
    "collectDate": DateFormat.yMd().format(DateTime.now()),
    "returnDate": DateFormat.yMd().format(DateTime.now()),
    "collectTime": DateFormat.jm().format(DateTime.now()),
    "returnTime": DateFormat.jm().format(DateTime.now()),
    "ticketNumber": 9,
    "displayPicture": 'images/Image_fifa22.jpeg'
  },
];

var historyDetailsTest = [
  {
    "name": "Overcooked",
    "qty": 1,
    "price": 5,
    "collected": DateFormat.yMd().add_jm().format(DateTime.now()),
    "returned": DateFormat.yMd().add_jm().format(DateTime.now()),
    "ticketNumber": 7,
    "displayPicture": 'images/Image_overcooked.jpg',
    "payments": {"bookFee": 5, "extensionFee": 2, "lateFee": 5.25}
  },
];

final now = "2022-03-17 13:20:00";

var notificationData = [
  {
    "storeName": "UROC",
    "itemName": "Overcooked",
    "collectTime": "2022-03-17 11:30:00",
    "returnTime": "2022-03-17 13:30:00",
    "ticketNumber": 7,
    "displayPicture": 'images/Image_uroc.png'
  },
  {
    "storeName": "UROC",
    "itemName": "Mario Kart Deluxe",
    "collectTime": "2022-03-17 13:20:00",
    "returnTime": "2022-03-17 15:00:00",
    "ticketNumber": 7,
    "displayPicture": 'images/Image_uroc.png'
  },
  {
    "storeName": "CISS",
    "itemName": "Jumper Wire",
    "collectTime": "2022-03-17 11:30:00",
    "returnTime": "2022-03-17 13:30:00",
    "ticketNumber": 7,
    "displayPicture": 'images/Image_ciss.png'
  },
  {
    "storeName": "CISS",
    "itemName": "Breadboard",
    "collectTime": "2022-03-17 13:20:00",
    "returnTime": "2022-03-17 15:00:00",
    "ticketNumber": 7,
    "displayPicture": 'images/Image_ciss.png'
  }
];
var stores = [
  {
    "store_name": "URCC @ Student Activity Centre",
    "address":
        "North Spine, NS3-01-03, 50 Nanyang Ave, Block N3.1, Singapore 639798",
    "category": "Recreational Games",
    "displayStorePicture": 'images/Image_uroc.png'
  },
  {
    "store_name": "Centre for Information Sciences and Systems (CISS)",
    "address": "50 Nanyang Ave S2-B4b-05, Singapore 639798",
    "category": "EEE Laboratories",
    "displayStorePicture": 'images/Image_ciss.png'
  },
];

var productDetails = [
  {
    "id": 'p1',
    "name": "Mario Kart Deluxe",
    "product_category": "Console Game",
    "pricePerhour": "1",
    "displayPicture": 'images/Image_mariokartdeluxe.jpg'
  },
  {
    "id": 'p2',
    "name": "Super Mario",
    "product_category": "Console Game",
    "pricePerhour": "1",
    "displayPicture": 'images/Image_supermario.jfif'
  },
  {
    "id": 'p3',
    "name": "Overcooked",
    "product_category": "Console Game",
    "pricePerhour": "1",
    "displayPicture": 'images/Image_overcooked.jpg'
  },
  {
    "id": 'p4',
    "name": "Fifa 22",
    "product_category": "Console Game",
    "pricePerhour": "1",
    "displayPicture": 'images/Image_fifa22.jpeg'
  },
  {
    "id": 'p5',
    "name": "Madden 18",
    "product_category": "Console Game",
    "pricePerhour": "1",
    "displayPicture": 'images/Image_madden18.jpg'
  }
];

var bookingsData = [
  {
    "name": "Overcooked",
    "qty": 1,
    "pricePerhour": 1,
    "price": 5,
    "collectDate": DateFormat.yMd().format(DateTime(2022, 3, 19)),
    "returnDate": DateFormat.yMd().format(DateTime.now()),
    "collectTime": DateFormat.jm().format(DateTime.now()),
    "returnTime": DateFormat.jm().format(DateTime.now()),
    "ticketNumber": 7,
    "displayPicture": 'images/Image_overcooked.jpg'
  },
  {
    "name": "Mario Kart Deluxe",
    "qty": 2,
    "pricePerhour": 1,
    "price": 10,
    "collectDate": DateFormat.yMd().format(DateTime.now()),
    "returnDate": '-',
    "collectTime": DateFormat.jm().format(DateTime.now()),
    "returnTime": '-',
    "ticketNumber": 28,
    "displayPicture": 'images/Image_mariokartdeluxe.jpg'
  },
  {
    "name": "FIFA 22",
    "qty": 3,
    "pricePerhour": 1,
    "price": 2.5,
    "collectDate": DateFormat.yMd().format(DateTime.now()),
    "returnDate": '-',
    "collectTime": DateFormat.jm().format(DateTime.now()),
    "returnTime": '-',
    "ticketNumber": 9,
    "displayPicture": 'images/Image_fifa22.jpeg'
  },
];

final Map userQR = {
  'username': 'user',
  'key':
      'UhYG2zeQjX4XQwoH/N3zm7JJVr2PNSx9CngexOBQIvduTSVL6FJmETCmUYb5oItUh6J3IKL3xYb/YoMOixkG44aU0+CH/BJIt14ysa9Mkt+l0wRYgw6fFMXgDIuqqKUZGO/86qK6F5/GyEieaZFCkoNyc96ax0IbwdeTG1nF7PvAn0xepH2m8/BusjrVsc8Iv5etRqzyvFQhh1hWLYC+up26L0xqjvQ14KeCzwBGeEKJ5G63jOlrYS2b0+8YaDv95vL23q0X5XUtqS2P14AlU6wMxPQgJgfevnPxMmsfphCgMW/jLYfZ8L5AUhb7s+ZwqdHdr1cxGdg56JxQYEpPOg==',
  'status': '1',
  'store': '0',
  'box': '1',
};

var userBookings = [
  {
    "user": "MICH0090@e.ntu.edu.sg",
    'itemBooked': [
      {
        "bookingID": "p5",
        "store": "UROC",
        "itemDetails": {
          "itemName": "Wafer",
          "pricePerhour": "1",
          "quantity": "1",
          "bookTime": DateFormat.jm().format(DateTime.now()),
          "collectTime": DateFormat.jm().format(DateTime.now()),
          "returnTime": DateFormat.jm().format(DateTime.now()),
          "paid": 0,
          "beforeImage": "images/wii_prevImage.png",
          "afterImage": "images/wii_empty.png"
        },
        "qrCode": {
          'username': 'user',
          'key':
              'UhYG2zeQjX4XQwoH/N3zm7JJVr2PNSx9CngexOBQIvduTSVL6FJmETCmUYb5oItUh6J3IKL3xYb/YoMOixkG44aU0+CH/BJIt14ysa9Mkt+l0wRYgw6fFMXgDIuqqKUZGO/86qK6F5/GyEieaZFCkoNyc96ax0IbwdeTG1nF7PvAn0xepH2m8/BusjrVsc8Iv5etRqzyvFQhh1hWLYC+up26L0xqjvQ14KeCzwBGeEKJ5G63jOlrYS2b0+8YaDv95vL23q0X5XUtqS2P14AlU6wMxPQgJgfevnPxMmsfphCgMW/jLYfZ8L5AUhb7s+ZwqdHdr1cxGdg56JxQYEpPOg==',
          'status': '1',
          'store': '0',
          'box': '1',
        }
      }
    ],
  }
];
