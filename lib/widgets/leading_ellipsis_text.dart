import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LeadingEllipsisText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const LeadingEllipsisText({
    Key? key,
    required this.text,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textPainter = TextPainter(
          text: TextSpan(text: text, style: style),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout(maxWidth: constraints.maxWidth);

        if (textPainter.didExceedMaxLines) {
          final ellipsis = '...';
          final ellipsisPainter = TextPainter(
            text: TextSpan(text: ellipsis, style: style),
            textDirection: TextDirection.ltr,
          );
          ellipsisPainter.layout();
          final ellipsisWidth = ellipsisPainter.width;

          final availableWidth = constraints.maxWidth - ellipsisWidth;
          final textWidth = textPainter.width;
          int visibleCharacters = 0;

          if (availableWidth > 0) {
            final TextPainter visibleTextPainter = TextPainter(
              text: TextSpan(text: text, style: style),
              textDirection: TextDirection.ltr,
            );
            visibleCharacters = (availableWidth / (textWidth / text.length)).floor();
            if (visibleCharacters < 0) visibleCharacters = 0;
          }

          final truncatedText = ellipsis + text.substring(text.length - visibleCharacters);

          return Text(
            truncatedText,
            style: style,
            overflow: TextOverflow.clip,
          );
        } else {
          return Text(
            text,
            style: style,
          );
        }
      },
    );
  }
}