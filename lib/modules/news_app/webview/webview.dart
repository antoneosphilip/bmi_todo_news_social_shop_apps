

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class web extends StatelessWidget {

  final String url;
web(this.url);


@override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(),
body:WebView(
  initialUrl: url,
)

    );
  }
}
