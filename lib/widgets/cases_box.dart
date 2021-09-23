import 'package:covid_track/widgets/percent_container.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class CasesBox extends StatelessWidget {
  final Color boxColor;
  final String title;
  final String casesNumber;
  final String subTitleTop;
  final String subTitleBottom;
  final String topPercent;
  final String bottomPercent;
  const CasesBox(
      {Key? key,
        required this.boxColor,
        required this.title,
        required this.casesNumber,
        required this.subTitleTop,
        required this.subTitleBottom,
        required this.topPercent,
        required this.bottomPercent,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: kDefaultPadding,
        horizontal: kDefaultPadding,
      ),
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toUpperCase(),
                  style: GoogleFonts.oswald(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  casesNumber,
                  style: GoogleFonts.oswald(
                    color: kWhiteColor,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PercentContainer(
                  percent: topPercent, 
                  subTitle: subTitleTop,
                  iconColor: Colors.green,
                  iconData: FontAwesomeIcons.arrowDown,
                ),
                SizedBox(height: 16),
                PercentContainer(
                  percent: bottomPercent, 
                  subTitle: subTitleBottom,
                  iconColor: kPrimaryColor,
                  iconData: FontAwesomeIcons.arrowUp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
