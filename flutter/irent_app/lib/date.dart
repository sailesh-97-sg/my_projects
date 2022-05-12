import 'package:flutter/material.dart';

class date extends StatefulWidget {
  final product_startdate;
  final product_enddate;

  date({this.product_startdate, this.product_enddate});
  @override
  State<date> createState() => _dateState();
}

class _dateState extends State<date> {
  DateTime dateTime1 = DateTime(2022);
  DateTime dateTime2 = DateTime(2022);

  @override
  Widget build(BuildContext context) {
    final difference = dateTime2.difference(dateTime1).inDays;
    print(difference);
    return Container(
      child: Row(
        children: <Widget>[
          Row(
            children: [
              Column(
                children: [
                  Container(
                    height: 30,
                    width: 100,
                    child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            DateTime? newDate1 = await showDatePicker(
                                context: context,
                                initialDate: dateTime1,
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2300));
                            if (newDate1 != null) {
                              setState(() {
                                dateTime1 = newDate1;
                              });
                            }
                          },
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Color.fromRGBO(0, 29, 74, 1),
                            size: 20,
                          ),
                          label: Text(
                              '${dateTime1.day}/${dateTime1.month}/${dateTime1.year}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 29, 74, 1),
                                  fontFamily: 'SF Pro Rounded',
                                  fontSize: 10,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.normal)),
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(158, 41),
                            primary: Color.fromRGBO(219, 228, 238, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        )),
                  ),
                ],
              ),
              SizedBox(height: 30, width: 5)
            ],
          ),
          Column(
            children: [
              Container(
                height: 30,
                width: 100,
                child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        DateTime? newDate2 = await showDatePicker(
                            context: context,
                            initialDate: dateTime2,
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2300));
                        if (newDate2 != null) {
                          setState(() {
                            dateTime2 = newDate2;
                          });
                        }
                      },
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: Color.fromRGBO(0, 29, 74, 1),
                        size: 20,
                      ),
                      label: Text(
                          '${dateTime2.day}/${dateTime2.month}/${dateTime2.year}',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Color.fromRGBO(0, 29, 74, 1),
                              fontFamily: 'SF Pro Rounded',
                              fontSize: 10,
                              letterSpacing: 0,
                              fontWeight: FontWeight.normal)),
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(158, 41),
                        primary: Color.fromRGBO(219, 228, 238, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
