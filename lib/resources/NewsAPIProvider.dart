import 'package:http/http.dart' show Client;
import 'dart:convert';

class NewsApiProvider {
  Client client = Client();

  fetchTopId() async {
    final response =
        await client.get('https://hacker-news.firebaseio.com/v0/maxitem.json');
    final ids = json.decode(response.body);

    return ids;
  }

  fetchItem(int id) async {
    final response =
        await client.get('https://hacker-news.firebaseio.com/v0/item/$id.json');
    final id = json.decode(response.body);

    return id;
  }
}
