import 'package:flutter/material.dart';
import 'package:katakana/core/models/kana_group.dart';
import 'package:katakana/kana/kana_bloc.dart';
import 'dart:collection';

import 'package:katakana/utils/circular_linked_list.dart';

class KanaPage extends StatefulWidget {
  KanaPage({Key key}) : super(key: key);

  @override
  _KanaPageState createState() => _KanaPageState();
}

class _KanaPageState extends State<KanaPage> {
  KanaBloc _bloc = KanaBloc();

  //Scripts enum currently contains only two elements, but using CircularLinkedList makes switching scalable
  // as we can Kanji to Scripts enum later on and wont have to worry about implement a way to toggle between the three.
  final _scripts =
      CircularLinkedList<Script>.fromIterable(Script.values);


  Script get _script => _scripts.current ?? _scripts.next();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _$ScriptToButtonText = {
    Script.Hiragana: 'あ',
    Script.Katakana: 'ア',
  };

  final _$ScriptToTitle = {
    Script.Hiragana: 'ひらがな (Hiragana)',
    Script.Katakana: 'カタカナ (Katakana)',
  };

  @override
  void initState() {
    super.initState();
    _bloc.fetchKanaGroups(_script);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(_script);
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(_$ScriptToTitle[_script]),
        ),
        floatingActionButton: FloatingActionButton(
          child: Text(_$ScriptToButtonText[_script]),
          onPressed: () {
            setState(() {
              _scripts.next();
            });
            _scaffoldKey.currentState.hideCurrentSnackBar();
            _bloc.fetchKanaGroups(_script);
          },
        ),
        body: StreamBuilder<List<KanaGroup>>(
            stream: _bloc.stream,
            builder: (context, snapshot) {
              final dataList = snapshot.hasError ? null : snapshot.data;
              return GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20.0),
                crossAxisSpacing: 10.0,
                crossAxisCount: 3,
                children: dataList
                        ?.map(
                          (group) => Card(
                            child: FlatButton(
                              color: Colors.deepOrangeAccent,
                              child: Text(group.letters.first.japanese,
                                  textScaleFactor: 4.0),
                              onPressed: () {
                                Navigator.pushNamed(context, group.id,
                                    arguments: group);
                              },
                            ),
                          ),
                        )
                        ?.toList() ??
                    [],
              );
            }));
  }
}
