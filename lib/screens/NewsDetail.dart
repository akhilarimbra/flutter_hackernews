import 'package:flutter/material.dart';

class NewsDetail extends StatelessWidget {
  final int itemId;

  NewsDetail({this.itemId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Detail',
      home: Scaffold(
        appBar: AppBar(
          title: Text('News Detail'),
        ),
        body: Text("I'm a details screen of $itemId"),
      ),
    );
  }
}
