import 'package:flutter/material.dart';
import 'package:covid_track/widgets/detailed_box.dart';

class RowDetailsCountryCases extends StatelessWidget {
  final Color boxColor;
  final List<String> titles;
  final List<String> texts;
  final List<Color> textColors;
  const RowDetailsCountryCases({Key? key, 
    required this.boxColor, 
    required this.titles, 
    required this.texts, 
    required this.textColors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: DetailedBox(
            colorBox: boxColor,
            textColor: textColors.first,
            title: titles.first,
            text: texts.first,
          ),
        ),
        SizedBox(width: 10),
        Flexible(
          child: DetailedBox(
            colorBox: boxColor,
            textColor: textColors.last,
            title: titles.last,
            text: texts.last,
          ),
        ),
      ],
    );
  }
}
