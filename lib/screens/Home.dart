import 'package:flutter/material.dart';
import 'dart:async';

import '../blocs/bloc_provider.dart';

import '../hn/hn.dart';
import '../hn/item.dart';

class Home extends StatelessWidget {
  final Future<List<Item>> items = HN().getTopStories();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Item>>(
        future: items,
        builder: (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
          Widget body;
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              body = Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.done:
              body = ListView(
                padding: const EdgeInsets.all(10.0),
                children: snapshot.data.map((item) {
                  return MiniNews(
                    subject: item.title,
                    author: item.by,
                    points: item.score.toString(),
                    commentsCount: item.descendants.toString(),
                    url: item.url,
                  );
                }).toList(),
              );
          }

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'What\'s 🔥 on Hacker News ?',
              ),
            ),
            body: body,
          );
        });
  }
}

// mininews utilisé dans home

class MiniNews extends StatefulWidget {
  final String subject;
  final String author;
  final String points;
  final String commentsCount;
  final String url;
  final Color bgColor;

  MiniNews(
      {Key key,
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
    final bloc = BlocProvider.of(context);

    void _tapedDown() {
      // todo newID => Streams(news)
      bloc.updateUrl.add(widget.url);
      print(widget.url);
      setState(() {
        child = _NewsAltHelp();
      });
    }

    void _tapedUp() {
      setState(() {
        child = _News(
          subject: widget.subject,
          author: widget.author,
          points: widget.points,
          commentsCount: widget.commentsCount,
        );
      });
    }

    return GestureDetector(
      onTapDown: (_) {
        _tapedDown();
      },
      onTapUp: (_) {
        _tapedUp();
      },
      onTapCancel: () {
        _tapedUp();
      },
      child: Container(
        padding: EdgeInsets.only(top: 5.0, right: 5.0, left: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: Colors.black26,
        ))),
        child: child,
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
                style:
                    TextStyle(color: Colors.grey, fontSize: 11.0, height: 1.3),
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
              ),
              Text(
                points,
                style: TextStyle(
                  fontSize: 10.0,
                ),
              ),
              Icon(
                Icons.comment,
                size: 15.0,
              ),
              Text(
                commentsCount,
                style: TextStyle(
                  fontSize: 10.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _NewsAltHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
      child: Row(
        children: <Widget>[
          Icon(Icons.arrow_left),
          Expanded(
            child: Text('Comments'),
          ),
          Text('Show News'),
          Icon(Icons.arrow_right),
        ],
      ),
      /*child: Row(
        children: <Widget>[
          Container(
              child: Text(
            'gauche',
            textAlign: TextAlign.left,
          )),
          Container(
              child: Text(
            'droite',
            textAlign: TextAlign.right,
          )),
        ],
      ),*/
    );
  }
}
