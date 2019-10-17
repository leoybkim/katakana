import 'package:flutter/material.dart';
import 'package:katakana/core/models/kana_group.dart';
import 'package:katakana/kana/kana_card.dart';

class KanaGroupPage extends StatefulWidget {
  KanaGroupPage({Key key, this.group}) : super(key: key);

  final KanaGroup group;

  @override
  _KanaGroupPageState createState() => _KanaGroupPageState();
}

class _KanaGroupPageState extends State<KanaGroupPage> with SingleTickerProviderStateMixin {
  _KanaGroupPageState();
  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final KanaGroup group = widget.group;
    return Scaffold(
      appBar: AppBar(
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(8.0),
        crossAxisSpacing: 10.0,
        crossAxisCount: 2,
        children: group.letters.map((kana) {
          return KanaCard(kana: kana);
        }).toList(),
      ),
    );
  }
}

