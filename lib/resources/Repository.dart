import 'dart:async';

import './NewsAPIProvider.dart';
import './NewsDBProvider.dart';
import '../models/Item.dart';

class Repository {
  // NewsDBProvider dbProvider = NewsDBProvider();
  // NewsApiProvider apiProvider = NewsApiProvider();

  List<Source> sources = <Source>[
    newsDBProvider,
    NewsApiProvider(),
  ];

  List<Cache> caches = <Cache>[newsDBProvider];

  Future<List<int>> fetchTopIds() => sources[1].fetchTopIds();

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    Source source;
    for (source in sources) {
      item = await source.fetchItem(id);
      if (item != null) break;
    }

    for (var cache in caches) {
      cache.addItem(item);
    }

    return item;
    // var item = await dbProvider.fetchItem(id);

    // if (item != null) {
    //   return item;
    // }

    // item = await apiProvider.fetchItem(id);
    // dbProvider.addItem(item);

    // return item;
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
  // Future<int> clear();
}
