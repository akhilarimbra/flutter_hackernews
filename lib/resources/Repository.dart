import '../models/Item.dart';
import 'dart:async';
import 'NewsAPIProvider.dart';
import 'NewsDBProvider.dart';

class Repository {
  NewsDBProvider dbProvider = NewsDBProvider();
  NewsApiProvider apiProvider = NewsApiProvider();

  fetchTopIds() {
    return apiProvider.fetchTopIds();
  }

  fetchItem(int id) async {
    var item = await dbProvider.fetchItem(id);

    if (item != null) {
      return item;
    }

    item = await apiProvider.fetchItem(id);
    dbProvider.addItem(item);

    return item;
  }
}
