import 'package:flutter/material.dart';

import './blocs/StoriesProvider.dart';
import './screens/NewsList.dart';

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
