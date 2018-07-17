import 'package:flutter/material.dart';

import './blocs/StoriesProvider.dart';
import './screens/NewsList.dart';
import './screens/NewsDetail.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoriesProvider(
      child: MaterialApp(
        title: 'HackerNews',
        // home: NewsList(),
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        onGenerateRoute: routes,
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) {
          return NewsList();
        },
      );
    } else {
      return MaterialPageRoute(
        builder: (context) {
          final int _itemId = int.parse(settings.name.replaceFirst('/', ''));
          print('Selected $_itemId');
          return NewsDetail(itemId: _itemId);
        },
      );
    }
  }
}
