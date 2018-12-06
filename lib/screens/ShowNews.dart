import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../blocs/bloc_provider.dart';

class ShowNews extends StatelessWidget {
  //WebViewController _controller;

  //final String _url;

  //ShowNews(this._url);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context);
    return Scaffold(
      body: StreamBuilder(
          stream: bloc.url,
          builder: (context, snapshot) {
            print("builder");
            if (snapshot.hasData) {
              print("HAS DATA");
              return Text(snapshot.data);
            } else {
              return CircularProgressIndicator();
            }
          }

          /*WebView(
            initialUrl: _url,
            javaScriptMode: JavaScriptMode.unrestricted,
            onWebViewCreated: (WebViewController _) {
              print('webviewcontroller created');
            },
          ),*/
          ),
    );
  }
}
