import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class WebviewBloc {
  String _url = 'https://dpp.st/';

  // Subject / sink
  final _url$ = BehaviorSubject<String>(seedValue: 'https://dpp.st/');

  // Observable / stream
  final _urlController = StreamController<String>.broadcast();
  //final _urlController = DeferStream;

  Sink<String> get updateUrl => _url$.sink;

  Stream<String> get url => _urlController.stream;

  void dispose() {
    _urlController.close();
    _url$.close();
  }
}
