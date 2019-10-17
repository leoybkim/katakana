import 'package:flutter/material.dart';
import 'package:katakana/kana/kana_bloc.dart';
import 'app_routes.dart' as Routes;
import 'kana_page.dart';

class KatakanaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'カタカナ',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: KanaPage(),
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}





