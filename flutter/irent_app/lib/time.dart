import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class time extends StatefulWidget {
  const time({Key? key}) : super(key: key);

  @override
  State<time> createState() => _timeState();
}

class _timeState extends State<time> {
  TimeOfDay _time = TimeOfDay.now();
  String initialValue_start = '12:00 AM';
  String initialValue_end = '12:00 AM';
  late int num1, num2;
  TextEditingController _timeController = TextEditingController();
  var itemList = [
    '12:00 AM',
    '1:00 AM',
    '2:00 AM',
    '3:00 AM',
    '4:00 AM',
    '5:00 AM',
    '6:00 AM',
    '7:00 AM',
    '8:00 AM',
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '1:00 PM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
    '5:00 PM',
    '6:00 PM',
    '7:00 PM',
    '8:00 PM',
    '9:00 PM',
    '10:00 PM',
    '11:00 PM',
  ];

  @override
  Widget build(BuildContext context) {
    // DateTime time2 = DateFormat.jm().parse(initialValue_end);
    // DateTime time1 = DateFormat.jm().parse(initialValue_end);
    // DateTime timestart = DateTime.parse(DateFormat("HH:mm").format(time1));
    // DateTime timeend = DateTime.parse(DateFormat("HH:mm").format(time2));

    //final difference = timeend.difference(timestart).inHours;
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
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(219, 228, 238, 1),
                        fixedSize: const Size(158, 41),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {},
                      child: Container(
                        child: DropdownButton(
                          style: TextStyle(
                              color: Color.fromRGBO(0, 29, 74, 1),
                              fontSize: 10),
                          dropdownColor: Color.fromRGBO(219, 228, 238, 1),
                          icon: Icon(Icons.keyboard_arrow_down,
                              color: Color.fromRGBO(0, 29, 74, 1)),
                          underline: Container(),
                          value: initialValue_start,
                          onChanged: (value_start) {
                            setState(() {
                              initialValue_start = value_start.toString();
                            });
                          },
                          menuMaxHeight: 150,
                          focusNode: FocusNode(),
                          isExpanded: true,
                          items: itemList.map((item_start) {
                            return DropdownMenuItem(
                                value: item_start, child: Text(item_start));
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
                width: 5,
              )
            ],
          ),
          Column(
            children: [
              Container(
                height: 30,
                width: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(219, 228, 238, 1),
                    fixedSize: const Size(158, 41),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {},
                  child: Container(
                    child: DropdownButton(
                      style: TextStyle(
                          color: Color.fromRGBO(0, 29, 74, 1), fontSize: 10),
                      dropdownColor: Color.fromRGBO(219, 228, 238, 1),
                      icon: Icon(Icons.keyboard_arrow_down,
                          color: Color.fromRGBO(0, 29, 74, 1)),
                      underline: Container(),
                      value: initialValue_end,
                      onChanged: (value_end) {
                        setState(() {
                          initialValue_end = value_end.toString();
                        });
                      },
                      menuMaxHeight: 150,
                      focusNode: FocusNode(),
                      isExpanded: true,
                      items: itemList.map((item_end) {
                        return DropdownMenuItem(
                            value: item_end, child: Text(item_end));
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
