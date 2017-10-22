import 'package:flutter/material.dart';
import 'package:katakana/components/animatedFlipCard.dart';

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
      home: new HomePage(title: 'カタカナ'),
      routes: <String, WidgetBuilder>{
        '/a': (BuildContext context) => new KatakanaPage(title: 'アイウエオ'),
        '/k': (BuildContext context) => new KatakanaPage(title: 'カキクケコ'),
        '/s': (BuildContext context) => new KatakanaPage(title: 'サシスセソ'),
        '/t': (BuildContext context) => new KatakanaPage(title: 'アイウエオ'),
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

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key:key);
  final String title;

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
                child: const Text('ア'),
                onPressed: () {
                  Navigator.push(context, new MaterialPageRoute(builder: (_)))
                },
              ),
            ),
            new Card(
              child: new FlatButton(
                child: const Text('カ'),
                onPressed: () { /* ... */ },
              ),
            ),
            new Card(
              child: new FlatButton(
                child: const Text('サ'),
                onPressed: () { /* ... */ },
              ),
            ),
            new Card(
              child: new FlatButton(
                child: const Text('タ'),
                onPressed: () { /* ... */ },
              ),
            ),
            new Card(
              child: new FlatButton(
                child: const Text('ナ'),
                onPressed: () { /* ... */ },
              ),
            ),
            new Card(
              child: new FlatButton(
                child: const Text('ハ'),
                onPressed: () { /* ... */ },
              ),
            ),
            new Card(
              child: new FlatButton(
                child: const Text('マ'),
                onPressed: () { /* ... */ },
              ),
            ),
            new Card(
              child: new FlatButton(
                child: const Text('ラ'),
                onPressed: () { /* ... */ },
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
        leading: new BackButton(),
        centerTitle: true,
        bottom: new PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
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
          child: new Text(katakana.phonetics, style: textStyle, textScaleFactor: 5.0),
        ),
      ),
    );
  }
}