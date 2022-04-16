import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:flutter_yjh/page/index_page.dart';

void main() {
  runApp(YjhApp());
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }

  FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
}

class YjhApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: IndexPage(),
        theme: ThemeData(
          primarySwatch: Colors.pink
        ),
      ),
    );
  }
}
