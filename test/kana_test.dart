import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:katakana/core/models/kana_group.dart';
import 'package:katakana/core/repositories/kana_repository.dart';
import 'package:katakana/kana/kana_bloc.dart';
import 'package:katakana/service_locator.dart';
import 'package:katakana/utils/disk_asset_bundle.dart';

void main() {
  registerServices();

  test('kana', () async {
    final repo = locator<KanaRepository>();
    repo.setAssetBundle(await DiskAssetBundle.loadGlob([
      // this registers a Future which probably is not the best way
      'json/katakana.json',
      'json/hiragana.json',
    ]));
    final katakanaGroups = repo.loadKanaGroups(Script.Katakana).catchError((e) => null);
    expect((await katakanaGroups).length, 10);

    final hiraganaGroups = repo.loadKanaGroups(Script.Hiragana);
    expect((await hiraganaGroups).length, 10);
  });


}
