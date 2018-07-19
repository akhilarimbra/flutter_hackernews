import 'package:flutter/material.dart';
import 'dart:async';
import '../blocs/CommentsProvider.dart';
import '../models/Item.dart';
import '../widgets/Comment.dart';

class NewsDetail extends StatelessWidget {
  final int itemId;

  NewsDetail({this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = CommentsProvider.of(context);

    return MaterialApp(
      title: 'News Detail',
      home: Scaffold(
        appBar: AppBar(
          title: Text('News Detail'),
        ),
        body: buildBody(bloc),
      ),
    );
  }

  Widget buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Text("Getting comments");
        }

        final itemFuture = snapshot.data[itemId];

        return FutureBuilder(
          future: itemFuture,
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return Text("Loading");
            }

            return buildList(itemSnapshot.data, snapshot.data);
          },
        );
      },
    );
  }

  Widget buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap) {
    final children = <Widget>[];
    children.add(buildTitle(item.title));
    final commentsList = item.kids.map((kidId) {
      return Comment(
        itemId: kidId,
        itemMap: itemMap,
        depth: 0,
      );
    }).toList();
    children.addAll(commentsList);

    return ListView(
      children: children,
    );
  }

  Widget buildTitle(String title) {
    return Container(
      child: Text(
        title,
        style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.center,
      ),
      margin: EdgeInsets.all(10.0),
      alignment: Alignment.topCenter,
    );
  }
}
