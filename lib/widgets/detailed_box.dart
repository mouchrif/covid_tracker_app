import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class DetailedBox extends StatelessWidget {
  final Color colorBox;
  final String title;
  final String text;
  final Color textColor;
  const DetailedBox(
      {Key? key,
      required this.colorBox,
      required this.title,
      required this.text, 
      required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: kDefaultPadding
      ),
      decoration: BoxDecoration(
        color: colorBox,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Column(
          children: [
            Text(
              title.toUpperCase(),
              style: GoogleFonts.oswald(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              text,
              style: GoogleFonts.oswald(
                color:textColor,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
