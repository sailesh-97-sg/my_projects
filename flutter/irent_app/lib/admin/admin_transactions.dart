import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:irent_app/admin/admin_constants.dart';
import 'package:irent_app/user_store_uroc.dart';
import 'dart:ui';
import '../app_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class admin_transactions extends StatefulWidget {
  const admin_transactions({Key? key}) : super(key: key);

  @override
  _admin_transactionsState createState() => _admin_transactionsState();
}

class _admin_transactionsState extends State<admin_transactions> {
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
  final TextStyle subtitleStyle = const TextStyle(
      fontFamily: 'SF_Pro_Rounded',
      fontWeight: FontWeight.w600,
      fontSize: 20,
      color: Color(0xFF001D4A));
  final TextStyle moneyStyle = const TextStyle(
      fontFamily: 'SF_Pro_Rounded',
      fontWeight: FontWeight.w600,
      fontSize: 30,
      color: Color(0xFFFBFBFF));

  List thetransactions = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Column(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Total Earnings',
                style: subtitleStyle,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 50,
                    width: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: aliceblue),
                    child: Center(
                      child: Text(
                        '\$20',
                        style: moneyStyle,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'My Bank Account',
                style: subtitleStyle,
              ),
              Divider(
                color: iceberg,
                thickness: 2,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 40,
                  width: 190,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Icon(
                            AppIcons.addbankaccount,
                            color: indigo,
                          )),
                      Expanded(
                          flex: 3,
                          child: Text('Add Bank Account',
                              style: TextStyle(
                                  fontFamily: 'SF_Pro_Rounded',
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                  color: oxford)))
                    ],
                  ),
                ),
              ),
              Divider(
                color: iceberg,
                thickness: 2,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      'Recent Transactions',
                      style: subtitleStyle,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: _dropDown(
                        context: context,
                        items: ['Today', 'Past 7 Days', 'Past Month']),
                  )
                ],
              ),
              Divider(color: iceberg, thickness: 2),
            ]),
            Expanded(
              //height: screenheight * 0.42,
              child: Container(
                child: ListView.builder(
                    itemCount: thetransactions.length,
                    itemBuilder: (context, index) {
                      return _transaction(
                          context: context,
                          ticketNumber: thetransactions[index].ticketNumber,
                          paymentDate: thetransactions[index].collectDate,
                          totalAmount: thetransactions[index].price);
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _dropDown({
    required BuildContext context,
    required List<String> items,
  }) {
    var dropdownValue;
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        height: 30,
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
            value: dropdownValue,
            isDense: true,
            onChanged: (newValue) {
              setState(() {
                dropdownValue = newValue;
              });
            },
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Future getTransactions() async {
    var thisdata =
        await FirebaseFirestore.instance.collection('transactions').get();
    {
      setState(() {
        thetransactions = List.from(
            thisdata.docs.map((doc) => TransactionDataModel.fromSnapshot(doc)));
        // storeData = newstores;
      });
    }
    ;
  }

  Widget _transaction(
      {required BuildContext context,
      required String ticketNumber,
      required Timestamp paymentDate,
      required String totalAmount}) {
    TextStyle _textStyle({required double size, required FontWeight weight}) {
      return TextStyle(
          fontFamily: 'SF_Pro_Rounded',
          fontSize: size,
          fontWeight: weight,
          color: Color(0xFF001D4A));
    }

    return Column(
      children: [
        Row(
          children: [
            Expanded(flex: 1, child: Icon(AppIcons.receivepayment, size: 25)),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Income',
                    style: _textStyle(size: 15, weight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      Text(
                        'from',
                        style: _textStyle(size: 10, weight: FontWeight.w200),
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Booking #$ticketNumber',
                        style: _textStyle(size: 10, weight: FontWeight.w400),
                      )
                    ],
                  ),
                  Text(
                    '${DateFormat('dd/MM/yyyy').format(paymentDate.toDate())}',
                    style: _textStyle(size: 12, weight: FontWeight.w500),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text(
                    '\$$totalAmount',
                    style: _textStyle(size: 15, weight: FontWeight.w500),
                  ),
                  Text(
                    'Completed',
                    style: _textStyle(size: 10, weight: FontWeight.w300),
                  )
                ],
              ),
            )
          ],
        ),
        Divider(color: iceberg, thickness: 1)
      ],
    );
  }
}

class TransactionDataModel {
  Timestamp collectDate = Timestamp.now();
  String price = "", ticketNumber = "";

  TransactionDataModel();
  Map<String, dynamic> toJson() => {
        'collectDate': collectDate,
        'price': price.toString(),
        'ticketNumber': ticketNumber.toString(),
        // 'item_id': item_id,
      };
  TransactionDataModel.fromSnapshot(snapshot)
      : collectDate = snapshot.data()['collectDate'],
        price = snapshot.data()['price'].toString(),
        ticketNumber = snapshot.data()['ticketNumber'].toString();
}
