import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class WebviewBloc {

  // Stream url
  final _url$ = BehaviorSubject<String>(seedValue: 'https://dpp.st/');

  Sink<String> get updateUrl => _url$.sink;

  Stream<String> get url => _url$.stream;

  void dispose() {
    //_urlController.close();
    _url$.close();
  }
}
