import 'package:flutter/material.dart';
import 'screens/NewsList.dart';
import 'blocs/StoriesProvider.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
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
