
import 'package:flutter/material.dart';
import 'kana_group_page.dart';

Route onGenerateRoute(RouteSettings settings) => MaterialPageRoute(
  builder: (context) => KanaGroupPage(group: settings.arguments),
);