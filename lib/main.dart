import 'package:flutter/material.dart';

void main() {
  runApp(new KatakanaApp());
}

class KatakanaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'カタカナ',
      theme: new ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: new KatakanaPage(title: 'カタカナ'),
    );
  }
}

class KatakanaPage extends StatefulWidget {
  KatakanaPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _KatakanaPageState createState() => new _KatakanaPageState();
}

class _KatakanaPageState extends State<KatakanaPage> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: katakanas.length);
  }

  void _nextPage(int delta) {
    final int newIndex = _tabController.index + delta;
    if (newIndex < 0 || newIndex >= _tabController.length)
      return;
    _tabController.animateTo(newIndex);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('カタカナ'),
        centerTitle: true,
        leading: new IconButton(
          tooltip: 'Previous choice',
          icon: const Icon(Icons.arrow_back),
          onPressed: () { _nextPage(-1); },
        ),
        actions: <Widget>[
          new IconButton(
            icon: const Icon(Icons.arrow_forward),
            tooltip: 'Next choice',
            onPressed: () { _nextPage(1); },
          ),
        ],
        bottom: new PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: new Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.white),
            child: new Container(
              height: 48.0,
              child: new TabPageSelector(controller: _tabController),
            ),
          ),
        ),
      ),
      body: new TabBarView(
        controller: _tabController,
        children: katakanas.map((Katakana katakana) {
          return new Padding(
            padding: const EdgeInsets.all(16.0),
            child: new KatakanaCard(katakana: katakana),
          );
        }).toList(),
      ),
    );
  }
}

// Katakana card class
class Katakana {
  const Katakana({ this.japanese, this.phonetics });
  final String japanese;
  final String phonetics;
}

// List of Katakana characters
const List<Katakana> katakanas = const <Katakana>[
  const Katakana(japanese: 'ア', phonetics: 'a'),
  const Katakana(japanese: 'イ', phonetics: 'i'),
  const Katakana(japanese: 'ウ', phonetics: 'u'),
  const Katakana(japanese: 'エ', phonetics: 'e'),
  const Katakana(japanese: 'オ', phonetics: 'o'),
];

class KatakanaCard extends StatelessWidget {
  const KatakanaCard({ Key key, this.katakana }) : super(key: key);

  final Katakana katakana;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return new Card(
      color: Colors.white,
      child: new Center(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Text(katakana.japanese, style: textStyle, textScaleFactor: 5.0),
          ],
        ),
      ),
    );
  }
}