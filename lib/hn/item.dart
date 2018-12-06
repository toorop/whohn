import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';

// Item represents a HN item (wahou really ?!)
class Item {
  final int id;
  final int time;
  final String by;
  final List<int> kids;
  final int score;
  final int descendants;
  final String title;
  final String type;
  final String url;

  Item(this.id, this.time, this.by, this.kids, this.score, this.descendants, this.title,
      this.type, this.url);

  static Future<Item> getInstance(String id) async {
    Response r =
        await get('https://hacker-news.firebaseio.com/v0/item/$id.json');
    // check status code
    if (r.statusCode != 200) {
      throw Exception('bad HTTP status returned by HN API: ${r.statusCode}');
    }

    var rawItem = jsonDecode(r.body);

    return new Item(
        int.parse(id),
        rawItem['time'],
        rawItem['by'],
        [],
        rawItem['score'],
        rawItem['descendants'],
        rawItem['title'],
        rawItem['type'],
        rawItem['url']);
  }
}
