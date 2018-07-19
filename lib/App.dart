import 'package:flutter/material.dart';

import './blocs/StoriesProvider.dart';
import './blocs/CommentsProvider.dart';
import './screens/NewsList.dart';
import './screens/NewsDetail.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          title: 'HackerNews',
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) {
          final storiesBloc = StoriesProvider.of(context);
          storiesBloc.fetchTopIds();
          return NewsList();
        },
      );
    } else {
      return MaterialPageRoute(
        builder: (context) {
          final int itemId = int.parse(settings.name.replaceFirst('/', ''));
          final commentBloc = CommentsProvider.of(context);

          commentBloc.fetchItemWithComments(itemId);
          return NewsDetail(itemId: itemId);
        },
      );
    }
  }
}
