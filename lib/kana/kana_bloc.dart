import 'dart:async';

import 'package:katakana/core/models/kana_group.dart';
import 'package:katakana/core/repositories/kana_repository.dart';
import 'package:katakana/service_locator.dart';
import 'package:rxdart/rxdart.dart';

class KanaBloc {
  final _kanaController = BehaviorSubject<List<KanaGroup>>();

  ValueObservable<List<KanaGroup>> get stream => _kanaController.stream;

  addGroup(List<KanaGroup> group) => _kanaController.add(group);

  fetchKanaGroups(Script script) {
    locator<KanaRepository>()
        .loadKanaGroups(script)
        .then(_kanaController.add)
        .catchError(_kanaController.addError);
  }

  void dispose() {
    _kanaController.close();
  }
}
