import 'package:flutter/material.dart';

import 'blocs/bloc_provider.dart';
import 'blocs/Webview_bloc.dart';

import 'screens/Home.dart';

void main() {
  final bloc = WebviewBloc();
  //final PageController pController = PageController();
  runApp(Whohn(bloc));
}

class Whohn extends StatelessWidget {
  final WebviewBloc bloc;

  Whohn(this.bloc);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        wvBloc: bloc,
        child: MaterialApp(
          title: 'whohn',
          theme: ThemeData(
            primaryColor: Colors.deepOrange,
          ),
          home: Home(),
        ));
  }
}
