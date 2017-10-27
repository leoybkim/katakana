import 'package:flutter/material.dart';
import 'package:katakana/components/animatedFlipCard.dart';

class KatakanaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'カタカナ',
      theme: new ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: new KanaPage(title: 'カタカナ'),
      routes: <String, WidgetBuilder>{
        '/a': (BuildContext context) => new KatakanaPage(title: 'アイウエオ'),
        '/k': (BuildContext context) => new KatakanaPage(title: 'カキクケコ'),
        '/s': (BuildContext context) => new KatakanaPage(title: 'サシスセソ'),
        '/t': (BuildContext context) => new KatakanaPage(title: 'タチツテト'),
        '/n': (BuildContext context) => new KatakanaPage(title: 'ナニヌネノ'),
        '/h': (BuildContext context) => new KatakanaPage(title: 'ハヒフヘホ'),
        '/m': (BuildContext context) => new KatakanaPage(title: 'マミムメモ'),
        '/y': (BuildContext context) => new KatakanaPage(title: 'ヤ　ユ　ヨ'),
        '/r': (BuildContext context) => new KatakanaPage(title: 'ラリルレロ'),
        '/w': (BuildContext context) => new KatakanaPage(title: 'ワ    ヲ'),
      },
    );
  }
}

class KanaPage extends StatefulWidget {
  KanaPage({Key key, this.title}) : super(key:key);
  final String title;

  @override
  _KanaPageState createState() => new _KanaPageState();
}

class _KanaPageState extends State<KanaPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: const Text('カタカナ'),
          centerTitle: true,
        ),
        body:
        new GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20.0),
          crossAxisSpacing: 10.0,
          crossAxisCount: 3,
          children: <Widget>[
            new Card(
              child: new FlatButton(
                color: Colors.deepOrangeAccent,
                child: const Text('ア', textScaleFactor: 5.0),
                onPressed: () {
                  Navigator.pushNamed(context, '/a');
                },
              ),
            ),
            new Card(
              child: new FlatButton(
                color: Colors.deepOrangeAccent,
                child: const Text('カ', textScaleFactor: 5.0),
                onPressed: () {
                  Navigator.pushNamed(context, '/k');
                },
              ),
            ),
            new Card(
              child: new FlatButton(
                color: Colors.deepOrangeAccent,
                child: const Text('サ', textScaleFactor: 5.0),
                onPressed: () {
                  Navigator.pushNamed(context, '/s');
                },
              ),
            ),
            new Card(
              child: new FlatButton(
                color: Colors.deepOrangeAccent,
                child: const Text('タ', textScaleFactor: 5.0),
                onPressed: () {
                  Navigator.pushNamed(context, '/t');
                },
              ),
            ),
            new Card(
              child: new FlatButton(
                color: Colors.deepOrangeAccent,
                child: const Text('ナ', textScaleFactor: 5.0),
                onPressed: () {
                  Navigator.pushNamed(context, '/n');
                },
              ),
            ),
            new Card(
              child: new FlatButton(
                color: Colors.deepOrangeAccent,
                child: const Text('ハ', textScaleFactor: 5.0),
                onPressed: () {
                  Navigator.pushNamed(context, '/h');
                },
              ),
            ),
            new Card(
              child: new FlatButton(
                color: Colors.deepOrangeAccent,
                child: const Text('マ', textScaleFactor: 5.0),
                onPressed: () {
                  Navigator.pushNamed(context, '/m');
                },
              ),
            ),
            new Card(
              child: new FlatButton(
                color: Colors.deepOrangeAccent,
                child: const Text('ラ', textScaleFactor: 5.0),
                onPressed: () {
                  Navigator.pushNamed(context, '/r');
                },
              ),
            )
          ],
        )
    );
  }

}

class KatakanaPage extends StatefulWidget {
  KatakanaPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _KatakanaPageState createState() => new _KatakanaPageState(title: title);
}

class _KatakanaPageState extends State<KatakanaPage> with SingleTickerProviderStateMixin {
  _KatakanaPageState({this.title});
  final String title;
  TabController _tabController;
  List<Katakana> _katakanas = katakanas;
  @override
  void initState() {
    super.initState();

    _katakanas = _katakanas.where((f)=>f.group == title).toList();
    _tabController = new TabController(vsync: this, length: _katakanas.length);
  }

  void _nextPage(int delta) {
    final int newIndex = _tabController.index + delta;
    if (newIndex < 0) {
      Navigator.pop(context);
    } else if (newIndex >= _tabController.length) {
      return;
    }
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
        bottom: new PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: new Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.white),
            child: new Container(
                height: 48.0,
                child: new Row(
                    children: <Widget>[
                      new IconButton(
                        tooltip: 'Previous choice',
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () { _nextPage(-1); },
                      ),
                      new Expanded(
                        child: new Center(child: new TabPageSelector(controller: _tabController)),
                      ),
                      new IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        tooltip: 'Next choice',
                        onPressed: () { _nextPage(1); },
                      ),
                    ]
                )
            ),
          ),
        ),
      ),
      body: new TabBarView(
        controller: _tabController,
        children: _katakanas.map((Katakana katakana) {
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
  const Katakana({ this.japanese, this.romaji, this.group });
  final String japanese;
  final String romaji;
  final String group;
}

// List of Katakana characters
const List<Katakana> katakanas = const <Katakana>[
  const Katakana(japanese: 'ア', romaji: 'a', group: 'アイウエオ'),
  const Katakana(japanese: 'イ', romaji: 'i', group: 'アイウエオ'),
  const Katakana(japanese: 'ウ', romaji: 'u', group: 'アイウエオ'),
  const Katakana(japanese: 'エ', romaji: 'e', group: 'アイウエオ'),
  const Katakana(japanese: 'オ', romaji: 'o', group: 'アイウエオ'),

  const Katakana(japanese: 'カ', romaji: 'ka', group: 'カキクケコ'),
  const Katakana(japanese: 'キ', romaji: 'ki', group: 'カキクケコ'),
  const Katakana(japanese: 'ク', romaji: 'ku', group: 'カキクケコ'),
  const Katakana(japanese: 'ケ', romaji: 'ke', group: 'カキクケコ'),
  const Katakana(japanese: 'コ', romaji: 'ko', group: 'カキクケコ'),

  const Katakana(japanese: 'サ', romaji: 'sa', group: 'サシスセソ'),
  const Katakana(japanese: 'シ', romaji: 'si', group: 'サシスセソ'),
  const Katakana(japanese: 'ス', romaji: 'su', group: 'サシスセソ'),
  const Katakana(japanese: 'セ', romaji: 'se', group: 'サシスセソ'),
  const Katakana(japanese: 'ソ', romaji: 'so', group: 'サシスセソ'),

  const Katakana(japanese: 'タ', romaji: 'ta', group: 'タチツテト'),
  const Katakana(japanese: 'チ', romaji: 'ti', group: 'タチツテト'),
  const Katakana(japanese: 'ツ', romaji: 'tu', group: 'タチツテト'),
  const Katakana(japanese: 'テ', romaji: 'te', group: 'タチツテト'),
  const Katakana(japanese: 'ト', romaji: 'to', group: 'タチツテト'),

  const Katakana(japanese: 'ナ', romaji: 'na', group: 'ナニヌネノ'),
  const Katakana(japanese: 'ニ', romaji: 'ni', group: 'ナニヌネノ'),
  const Katakana(japanese: 'ヌ', romaji: 'nu', group: 'ナニヌネノ'),
  const Katakana(japanese: 'ネ', romaji: 'ne', group: 'ナニヌネノ'),
  const Katakana(japanese: 'ノ', romaji: 'no', group: 'ナニヌネノ'),

  const Katakana(japanese: 'ハ', romaji: 'ha', group: 'ハヒフヘホ'),
  const Katakana(japanese: 'ヒ', romaji: 'hi', group: 'ハヒフヘホ'),
  const Katakana(japanese: 'フ', romaji: 'hu', group: 'ハヒフヘホ'),
  const Katakana(japanese: 'ヘ', romaji: 'he', group: 'ハヒフヘホ'),
  const Katakana(japanese: 'ホ', romaji: 'ho', group: 'ハヒフヘホ'),

  const Katakana(japanese: 'マ', romaji: 'ma', group: 'マミムメモ'),
  const Katakana(japanese: 'ミ', romaji: 'mi', group: 'マミムメモ'),
  const Katakana(japanese: 'ム', romaji: 'mu', group: 'マミムメモ'),
  const Katakana(japanese: 'メ', romaji: 'me', group: 'マミムメモ'),
  const Katakana(japanese: 'モ', romaji: 'mo', group: 'マミムメモ'),
];

class KatakanaCard extends StatelessWidget {
  const KatakanaCard({ Key key, this.katakana }) : super(key: key);

  final Katakana katakana;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;

    return new AnimatedFlipCard(
      firstWidget: new Card(
        color: Colors.white,
        child: new Center(
          child: new Text(katakana.japanese, style: textStyle, textScaleFactor: 5.0),
        ),
      ),
      secondWidget: new Card(
        color: Colors.white,
        child: new Center(
          child: new Text(katakana.romaji, style: textStyle, textScaleFactor: 5.0),
        ),
      ),
    );
  }
}