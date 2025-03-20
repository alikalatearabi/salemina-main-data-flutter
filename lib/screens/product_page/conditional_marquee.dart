import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class ConditionalMarquee extends StatelessWidget {
  final String text;
  final double maxWidth;
  final TextStyle textStyle;
  final int maxCharacters;

  const ConditionalMarquee({
    Key? key,
    required this.text,
    required this.maxWidth,
    required this.textStyle,
    required this.maxCharacters ,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (text.length > maxCharacters) {
      return SizedBox(
        width: maxWidth,
        height: MediaQuery.of(context).size.height * 0.0279898218829516539440203562341,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Marquee(
            text: text,
            style: textStyle,
            scrollAxis: Axis.horizontal,
            blankSpace: 20.0,
            velocity: 30.0,
            pauseAfterRound: Duration(seconds: 1),
            startPadding: 10.0,
            accelerationDuration: Duration(seconds: 1),
            accelerationCurve: Curves.linear,
            decelerationDuration: Duration(seconds: 1),
            decelerationCurve: Curves.easeOut,
          ),
        ),
      );
    } else {
      return SizedBox(
        width: maxWidth,
        height: MediaQuery.of(context).size.height * 0.0279898218829516539440203562341,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            text,
            style: textStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    }
  }
}