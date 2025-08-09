import 'package:flutter/material.dart';

import '../../models/exercise.dart';


class MistakeTextView extends StatelessWidget {
  final String text;
  final List<Mistakes> mistakes;

  const MistakeTextView({
    super.key,
    required this.text,
    required this.mistakes,
  });

  @override
  Widget build(BuildContext context) {
    List<InlineSpan> spans = [];

    for (int i = 0; i < text.length; i++) {
      final isMistake = mistakes.any((m) => m.position == i);
      final mistake = mistakes.firstWhere(
            (m) => m.position == i,
        orElse: () => Mistakes(),
      );

      final char = text[i];

      spans.add(TextSpan(
        text: char,
        style: TextStyle(
          fontSize: 22,
          color: isMistake ? _getColorByMistakeType(mistake.type) : Colors.black,
          fontWeight: isMistake ? FontWeight.bold : FontWeight.normal,
        ),
      ));
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: RichText(
        text: TextSpan(children: spans),
      ),
    );
  }

  Color _getColorByMistakeType(String? type) {
    switch (type) {
      case 'omission':
        return Colors.red;
      case 'replacement':
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }
}
