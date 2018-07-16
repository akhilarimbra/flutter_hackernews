import 'package:flutter/material.dart';
import 'screens/NewsList.dart';
import 'blocs/StoriesProvider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoriesProvider(
      child: MaterialApp(
        title: 'HackerNews',
        home: NewsList(),
        theme: ThemeData.dark(),
      ),
    );
  }
}
