import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:katakana/core/models/kana_group.dart';
import 'package:katakana/service_locator.dart';
import 'package:katakana/utils/disk_asset_bundle.dart';

class KanaRepository {
  final _$ScriptToFileName = {
    Script.Hiragana: 'hiragana',
    Script.Katakana: 'katakana',
  };

  AssetBundle _assetBundle = rootBundle;

  setAssetBundle(AssetBundle assetBundle) {
    _assetBundle = assetBundle;
  }

  Future<List<KanaGroup>> loadKanaGroups(Script script) =>
      _assetBundle.loadStructuredData(
          'assets/json/${_$ScriptToFileName[script]}.json',
          (jsonString) async => (json.decode(jsonString) as List)
              .map((json) => KanaGroup.fromJson(json))
              .toList());
}
