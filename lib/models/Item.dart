import 'dart:convert';

class ItemModel {
  final int id;
  final bool deleted;
  final String type;
  final String by;
  final int time;
  final String text;
  final bool dead;
  final int parent;
  final List<dynamic> kids;
  final String url;
  final int score;
  final String title;
  final int descendants;

  ItemModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        deleted = parsedJson['deleted'],
        type = parsedJson['type'],
        by = parsedJson['by'],
        time = parsedJson['time'],
        text = parsedJson['text'],
        dead = parsedJson['dead'],
        parent = parsedJson['parent'],
        kids = parsedJson['kids'],
        url = parsedJson['url'],
        score = parsedJson['score'],
        title = parsedJson['title'],
        descendants = parsedJson['descendants'];

  ItemModel.fromDatabase(Map<String, dynamic> parsedDatabase)
      : id = parsedDatabase['id'],
        deleted = parsedDatabase['deleted'] == 1,
        type = parsedDatabase['type'],
        by = parsedDatabase['by'],
        time = parsedDatabase['time'],
        text = parsedDatabase['text'],
        dead = parsedDatabase['dead'] == 1,
        parent = parsedDatabase['parent'],
        kids = jsonDecode(parsedDatabase['kids']),
        url = parsedDatabase['url'],
        score = parsedDatabase['score'],
        title = parsedDatabase['title'],
        descendants = parsedDatabase['descendants'];

  Map<String, dynamic> toMapDatabase() {
    return <String, dynamic>{
      "id": id,
      "type": type,
      "by": by,
      "time": time,
      "text": text,
      "parent": parent,
      "url": url,
      "score": score,
      "title": title,
      "descendants": descendants,
      "dead": dead ? 1 : 0,
      "deleted": deleted ? 1 : 0,
      "kids": jsonEncode(kids),
    };
  }
}
