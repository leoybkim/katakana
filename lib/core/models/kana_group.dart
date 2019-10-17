import 'package:meta/meta.dart';
import 'kana.dart';

enum Script { Hiragana, Katakana }
Script _$ScriptFromId(int id) => Script.values[id];

@immutable
class KanaGroup {
  final String id;
  final Script script;
  final Iterable<Kana> letters;

  KanaGroup._(this.id, this.script, this.letters);

  factory KanaGroup.fromJson(Map<String, dynamic> json) => KanaGroup._(
      json["id"] as String,
      _$ScriptFromId(json["script"] as int),
      (json["letters"] as List).map((kanaMap) => Kana.fromJson(kanaMap)));

  Map<String, dynamic> get toJson => {
        'id': this.id,
        'script': this.script.index,
        'letters': letters.map((kana) => kana.toJson).toList(),
      };
}
