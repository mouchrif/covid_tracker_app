import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class PercentContainer extends StatelessWidget {
  final String percent;
  final String subTitle;
  final IconData iconData;
  final Color iconColor;
  const PercentContainer({
    Key? key,
    required this.percent,
    required this.subTitle,
    required this.iconData,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Icon(
            iconData,
            color: iconColor,
            size: 15.0,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                percent,
                style: GoogleFonts.oswald(
                  color: kWhiteColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subTitle,
                style: GoogleFonts.oswald(
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
