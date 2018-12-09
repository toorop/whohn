import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'item.dart';

const String bestStoriesURL =
    'https://hacker-news.firebaseio.com/v0/beststories.json';
const String topStoriesURL =
    'https://hacker-news.firebaseio.com/v0/topstories.json';

class HN {
  Future<List<int>> getBestStoriesIDs() async {
    Response response = await get(topStoriesURL);
    if (response.statusCode != 200) {
      throw Exception('bad status code from HN API: ${response.statusCode}');
    }
    final parsed = jsonDecode(response.body);
    List<int> storiesIDs = List<int>.from(parsed);
    return storiesIDs;
  }

  Future<dynamic> getBestStories() async {
    List<Item> stories = [];
    List<int> storiesIDs = [];
    storiesIDs = await getBestStoriesIDs();
    print(storiesIDs);

    await Future.forEach(storiesIDs.sublist(0, 15), (id) async {
      stories.add(await Item.getInstance(id.toString()));
    });

    return stories;
  }

  // Multiple future
  Future<List<Item>> getBestStories2() async {
    List<int> storiesIDs = await getBestStoriesIDs();
    List<Item> stories = new List(30);
    List<Future> futures = [];

    print('start');

    int i = -1;

    storiesIDs.sublist(0, 30).forEach((id) => futures.add(
        //Item.getInstance(id.toString()))
        addToList(stories, ++i, id)));

    await Future.wait(futures);

    stories.forEach((Item item) => print(item.title));

    return stories;
  }

  Future<void> addToList(List stories, int i, int id) async {
    Item item = await Item.getInstance(id.toString());
    stories[i] = item;
  }

  // via API
  Future<List<Item>> getTopStories() async {
    List<Item> stories = [];
    Response response = await get('https://api.whohn.app/top/0/40');
    if (response.statusCode != 200) {
      throw Exception('bad status code from whohn API: ${response.statusCode}');
    }
    final parsed = jsonDecode(response.body);
    parsed.forEach((_, item) {
      stories.add(Item(item['id'], item['time'], item['by'], [], item['score'],
          item['descendants'], item['title'], item['type'], item['url']));
    });

    return stories;
  }
}
