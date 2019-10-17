import 'package:flutter/widgets.dart';
import 'package:katakana/service_locator.dart' as Locator;
import 'kana/app.dart';

void main() {
  Locator.registerServices();
  runApp(KatakanaApp());
}
