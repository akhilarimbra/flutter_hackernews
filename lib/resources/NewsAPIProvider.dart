import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'dart:async';
import '../models/Item.dart';

final String _rootUrl = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider {
  Client client = Client();

  Future<List<int>> fetchTopIds() async {
    final response = await client.get('$_rootUrl/maxitem.json');
    final ids = json.decode(response.body);

    return ids;
  }

  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get('$_rootUrl/item/$id.json');
    final parsedJson = json.decode(response.body);

    return ItemModel.fromJson(parsedJson);
  }
}
