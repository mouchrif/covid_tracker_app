import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:covid_track/constants.dart';

class LastUpdateStatistics extends StatelessWidget {
  final DateTime date;
  const LastUpdateStatistics({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "Last UpDate :  ",
            style: GoogleFonts.lato(
              color: kTextColor,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: "${DateFormat.yMMMd().add_Hm().format(date)}",
            style: GoogleFonts.lato(
              color: Colors.green,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
