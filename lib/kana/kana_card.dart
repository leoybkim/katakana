import 'package:flutter/material.dart';
import 'package:katakana/core/components/animatedFlipCard.dart';
import 'package:katakana/core/models/kana.dart';

class KanaCard extends StatelessWidget {
  const KanaCard({ Key key, this.kana }) : super(key: key);

  final Kana kana;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;

    return AnimatedFlipCard(
      firstWidget: Card(
        color: Colors.white,
        child: Center(
          child: Text(kana.japanese, style: textStyle, textScaleFactor: 3,),
        ),
      ),
      secondWidget: Card(
        color: Colors.white,
        child: Center(
          child: Text(kana.romaji, style: textStyle, textScaleFactor: 3,),
        ),
      ),
    );
  }
}