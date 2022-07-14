// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, unused_local_variable, avoid_print, sized_box_for_whitespace

import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:bitespot/user/menu_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beacon/flutter_beacon.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

Map myMap = {};
Map myStoreLocationsMap = {};

class _UserHomePageState extends State<UserHomePage> {
  final regions = <Region>[];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ins();
  }

  // ignore: prefer_final_fields

  @override
  Widget build(BuildContext context) {
    regions.add(Region(identifier: 'com.beacon'));

    var _streamRanging =
        flutterBeacon.ranging(regions).listen((RangingResult result) {
      print('Information of beacon: ' + result.beacons.toString());
      print('UUID of first beacon: ' +
          result.beacons[0].proximityUUID.toString());
      var streamRegion = result.region.proximityUUID;
      print(result.toJson.toString());
    });

    StreamSubscription _subscription;

    // RangingResult.from(_streamRanging).region.identifier.toString();
    // _streamRanging.onData((data) {
    //   data.region.proximityUUID.toString();
    // });
    return Container(
      padding: EdgeInsets.all(20),
      child: StreamBuilder(
        stream: flutterBeacon.ranging(regions),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            Map<String, dynamic> beacondata =
                jsonDecode(snapshot.data.toString());
            return ListView.builder(
              itemBuilder: (BuildContext context, index) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   beacondata['beacons'].toString(),
                      //   style: TextStyle(color: Colors.white),
                      // )
                      myMap[beacondata['beacons'][index]['proximityUUID']] !=
                              null
                          ? GestureDetector(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        myMap[beacondata['beacons'][index]
                                                ['proximityUUID']]
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 27),
                                      ),
                                      Text(
                                        'Distance: ' +
                                            beacondata['beacons'][index]
                                                    ['proximity']
                                                .toString(),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => MenuScreen(
                                              storeUUID: beacondata['beacons']
                                                  [index]['proximityUUID'],
                                              storeName: myMap[
                                                  beacondata['beacons'][index]
                                                      ['proximityUUID']],
                                            ))));
                              },
                            )
                          : Container(),
                      // Text(beacondata['beacons'].toString()),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                );
              },
              itemCount: beacondata['beacons'].length,
            );
            // return Text(
            //   beacondata['beacons'][1]['proximityUUID'].toString(),
            //   style: TextStyle(color: Colors.white),
            // );
          }
          throw '';
        },
      ),
    );
  }
}

Future<void> ins() async {
  var myStores = await FirebaseFirestore.instance
      .collection('storeNames')
      .doc('stores')
      .get();

  myMap = myStores['storeUUIDs'];
  myStoreLocationsMap = myStores['storeMajorLocations'];
}
