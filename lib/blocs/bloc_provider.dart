import 'package:flutter/material.dart';

import 'Webview_bloc.dart';

class BlocProvider extends InheritedWidget {
  final WebviewBloc wvBloc;

  BlocProvider({Key key, this.wvBloc, child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static WebviewBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider)
          .wvBloc;
}
