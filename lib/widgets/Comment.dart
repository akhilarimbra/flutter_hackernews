import 'dart:async';
import 'package:flutter/material.dart';
import '../models/Item.dart';
import './LoadingContainer.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  Comment({this.itemId, this.itemMap, this.depth});

  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        final item = snapshot.data;
        final children = <Widget>[
          ListTile(
            title: buildText(item.text),
            subtitle: item.by != '' ? Text(item.by) : Text('Comment Deleted'),
            contentPadding: EdgeInsets.only(
              left: 16.0 + (depth * 16.0),
              right: 16.0,
            ),
          ),
          Divider(),
        ];

        snapshot.data.kids.forEach((kidId) {
          children.add(Comment(
            itemId: kidId,
            itemMap: itemMap,
            depth: depth + 1,
          ));
        });

        return Column(children: children);
      });

  Widget buildText(String text) => Text(text
      .replaceAll('&#x27;', "'")
      .replaceAll('<p>', '\n')
      .replaceAll('</p>', '\n'));
}
