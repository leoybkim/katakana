import 'package:meta/meta.dart';

@immutable
class Kana {
  const Kana({this.japanese, this.romaji});
  final String japanese;
  final String romaji;

  factory Kana.fromJson(Map<String, dynamic> json) => Kana(
        japanese: json["japanese"],
        romaji: json["romaji"],
      );

  Map<String, dynamic> get toJson => {
        'japanese': this.japanese,
        'romaji': this.romaji,
      };
}
