import 'package:flutter/cupertino.dart';

class CategoriesScroller extends StatelessWidget {
  const CategoriesScroller({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double categoryHeight = 70;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 05, horizontal: 05),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
          child: Row(
            children: <Widget>[
              Container(
                width: 74,
                margin: EdgeInsets.only(right: 15),
                height: categoryHeight,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color:
                              Color.fromRGBO(32, 32, 32, 0.05000000074505806),
                          offset: Offset(0, 30),
                          blurRadius: 60)
                    ],
                    color: Color.fromRGBO(219, 228, 238, 1),
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text("Consoles",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'SF Pro Rounded',
                            color: Color.fromRGBO(39, 33, 77, 1),
                            fontWeight: FontWeight.normal,
                            height: 1,
                          )),
                    ],
                  ),
                ),
              ),
              Container(
                width: 74,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color:
                              Color.fromRGBO(32, 32, 32, 0.05000000074505806),
                          offset: Offset(0, 30),
                          blurRadius: 60)
                    ],
                    color: Color.fromRGBO(219, 228, 238, 1),
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "CD Games",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'SF Pro Rounded',
                            color: Color.fromRGBO(39, 33, 77, 1),
                            fontWeight: FontWeight.normal,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 74,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color:
                              Color.fromRGBO(32, 32, 32, 0.05000000074505806),
                          offset: Offset(0, 30),
                          blurRadius: 60)
                    ],
                    color: Color.fromRGBO(219, 228, 238, 1),
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "Board Games",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SF Pro Rounded',
                          color: Color.fromRGBO(39, 33, 77, 1),
                          fontWeight: FontWeight.normal,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 74,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color:
                              Color.fromRGBO(32, 32, 32, 0.05000000074505806),
                          offset: Offset(0, 30),
                          blurRadius: 60)
                    ],
                    color: Color.fromRGBO(219, 228, 238, 1),
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "Card Games",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SF Pro Rounded',
                          color: Color.fromRGBO(39, 33, 77, 1),
                          fontWeight: FontWeight.normal,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
