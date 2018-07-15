import 'package:flutter/material.dart';
import '../blocs/StoriesProvider.dart';

class NewsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewsListState();
  }
}

class NewsListState extends State<NewsList> {
  @override
  Widget build(BuildContext context) {
    final _bloc = StoriesProvider.of(context);
    _bloc.fetchTopIds();

    return Scaffold(
      appBar: AppBar(
        title: Text('Top news'),
        centerTitle: true,
      ),
      body: buildList(_bloc),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, int index) {
            return Text('${snapshot.data[index]}');
          },
        );
      },
    );
  }
}
