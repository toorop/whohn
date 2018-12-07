import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../blocs/bloc_provider.dart';


class DisplayNews extends StatelessWidget {
  final String _url;
  DisplayNews(this._url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        title: Text(
          'Return to news',
        ),
      ),
      body: WebView(
        initialUrl: _url,
        javaScriptMode: JavaScriptMode.unrestricted,
      ),
    );
  }
}



class ShowNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Return to news list',
        ),
      ),
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
