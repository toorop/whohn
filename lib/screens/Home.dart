import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

import './ShowNews.dart';
import './DisplayComments.dart';

import '../hn/hn.dart';
import '../hn/item.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Item> _items = new List<Item>();

  @override
  void initState() {
    super.initState();

    _handleRefresh();
  }

  @override
  Widget build(BuildContext context) {
    /*if (_items.isEmpty) {
      _handleRefresh();
    }*/
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'What\'s 🔥 on Hacker News ?',
        ),
      ),
      body: _items.isEmpty
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              child: Container(
                color: Colors.deepOrange.shade100,
                child: ListView(
                  padding: const EdgeInsets.only(top: 1.0),
                  children: _items.map((item) {
                    //print(item.title);
                    return MiniNews(
                      id: item.id,
                      subject: item.title,
                      author: item.by,
                      points: item.score.toString(),
                      commentsCount: item.descendants.toString(),
                      url: item.url,
                    );
                  }).toList(),
                ),
              ),
              onRefresh: _handleRefresh,
              color: Colors.deepOrange,
            ),
    );
  }

  Future<Null> _handleRefresh() async {
    setState(() {
      _items = new List<Item>();
    });
    List<Item> _i = await HN().getTopStories();
    print('on setstate');
    setState(() {
      //print(_i[3].title);
      _items = _i;
    });
  }
}

// mininews utilisé dans home
class MiniNews extends StatefulWidget {
  final int id;
  final String subject;
  final String author;
  final String points;
  final String commentsCount;
  final String url;
  final Color bgColor;

  MiniNews(
      {Key key,
      this.id,
      this.subject,
      this.author,
      this.points,
      this.commentsCount,
      this.url,
      this.bgColor})
      : super(key: key);

  _MiniNewsState createState() => _MiniNewsState();
}

class _MiniNewsState extends State<MiniNews> {
  Widget child;

  initState() {
    super.initState();
    child = _News(
      subject: widget.subject,
      author: widget.author,
      points: widget.points,
      commentsCount: widget.commentsCount,
    );
  }

  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.id.toString() + Random().nextInt(10000).toString()),
      resizeDuration: const Duration(milliseconds: 1),
      onDismissed: (DismissDirection direction) {
        if (direction == DismissDirection.startToEnd) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DisplayNews(widget.url)),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DisplayComments()),
          );
        }
      },
      background: DismissibleBkgNews(),
      secondaryBackground: DismissibleBkgComments(),
      child: Container(
        color: Color.fromRGBO(246, 246, 239, 1.0),
        margin: EdgeInsets.only(bottom: 1.0),
        padding: EdgeInsets.only(top: 7.0, right: 5.0, left: 5.0, bottom: 5.0),
        child: child,
      ),
    );
  }
}

class DismissibleBkgNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepOrange,
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Row(
        children: <Widget>[
          Text(' '),
          Icon(
            Icons.open_in_new,
            size: 16.0,
            color: Colors.white,
          ),
          Text(
            '  Display news',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              //fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}

class DismissibleBkgComments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepOrange,
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            'Comments  ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              //fontWeight: FontWeight.bold,
            ),
          ),
          Icon(
            Icons.comment,
            size: 16.0,
            color: Colors.white,
          ),
          Text('  '),
        ],
      ),
    );
  }
}

// _News represent la news à afficher
class _News extends StatelessWidget {
  final String subject;
  final String author;
  final String points;
  final String commentsCount;
  final Color bgColor;

  _News(
      {Key key,
      this.subject,
      this.author,
      this.points,
      this.commentsCount,
      this.bgColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  subject,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // author

              Text(
                author,
                style: TextStyle(
                    color: Colors.grey.shade700, fontSize: 11.0, height: 1.3),
              ),

              // spacer
              Container(
                margin: EdgeInsets.only(top: 5.0),
              ),
            ],
          ),
        ),
        ///////
        // Points & comments
        Container(
          margin: EdgeInsets.only(left: 2.3),
          child: Column(
            children: <Widget>[
              Icon(
                Icons.thumb_up,
                size: 15.0,
                color: Colors.deepOrange,
              ),
              Text(
                points,
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.grey.shade900,
                ),
              ),
              Icon(
                Icons.comment,
                size: 15.0,
                color: Colors.deepOrange,
              ),
              Text(
                commentsCount,
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.grey.shade900,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
