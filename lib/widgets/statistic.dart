import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

class Statistic extends StatelessWidget {
  final Color color;
  final dynamic text;
  final String title;
  const Statistic(
      {Key? key, required this.title, required this.color, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _formatedNumber = NumberFormat.compact().format(text);
    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding / 2, vertical: kDefaultPadding / 2),
        decoration: BoxDecoration(
          color: kCardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _formatedNumber,
              style: GoogleFonts.lato(
                color: kWhiteColor,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  title,
                  style: GoogleFonts.lato(
                    color: kTextColor,
                    //fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  FontAwesomeIcons.caretUp,
                  color: color,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
