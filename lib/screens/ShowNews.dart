import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../blocs/bloc_provider.dart';

class ShowNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context);
    return Scaffold(
      body: StreamBuilder(
          stream: bloc.url,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return WebView(
                initialUrl: snapshot.data,
                javaScriptMode: JavaScriptMode.unrestricted,
                onWebViewCreated: (WebViewController _) {
                  print('webviewcontroller created');
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
