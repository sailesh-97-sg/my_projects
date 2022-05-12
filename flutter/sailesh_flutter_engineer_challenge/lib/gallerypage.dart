// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, prefer_collection_literals

import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'dart:convert';
import 'package:like_button/like_button.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

String stringResponse = "";
Map mapResponse = Map();
Map dataResponse = Map();
List listResponse = [];

class _GalleryPageState extends State<GalleryPage> {
  bool isLiked = false;
  int likeCount = 0;
  List isLikedList = [false];

  Future apiCaller() async {
    https.Response response;
    response = await https.get(
        Uri.parse("https://itunes.apple.com/lookup?id=183313439&entity=album"));
    if (response.statusCode == 200) {
      setState(() {
        stringResponse = response.body;
        mapResponse = json.decode(response.body);
        listResponse = mapResponse['results'];
      });
    }
  }

  @override
  void initState() {
    apiCaller();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i < listResponse.length; i++) {
      isLikedList.add(false);
    }
    print(isLikedList);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[850],
        appBar: AppBar(
          title: Text('Albums'),
          backgroundColor: Colors.black,
          actions: [
            Container(
              padding: EdgeInsets.only(right: 40),
              child: Row(
                children: [
                  LikeButton(
                      size: 20,
                      isLiked: true,
                      likeCount: likeCount,
                      onTap: (bool isLiked) async {}),
                ],
              ),
            )
          ],
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            if (index == 0) {
              return Container();
            } else
              return Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                  left: 10,
                  top: 5,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.network(
                          listResponse[index]['artworkUrl100'] ?? '',
                        ),
                        SizedBox(width: 14),
                        SizedBox(
                          width: 190,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(listResponse[index]['collectionName'],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13)),
                              Text(listResponse[index]['artistName'],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13)),
                              Text(
                                  listResponse[index]['releaseDate']
                                      .substring(0, 10),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13)),
                              Text(
                                  '\$' +
                                      listResponse[index]['collectionPrice']
                                          .toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13)),
                            ],
                          ),
                        ),
                        Expanded(
                          child: LikeButton(
                            size: 30,
                            isLiked: isLikedList[index],
                            onTap: (isLiked) async {
                              setState(() {
                                isLikedList[index] = !isLiked;
                                if (isLikedList[index]) {
                                  likeCount++;
                                } else {
                                  likeCount--;
                                }
                                isLiked = !isLiked;
                              });
                              return isLiked;
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              );
          },
          itemCount: listResponse.length,
        ),
      ),
    );
  }
}
