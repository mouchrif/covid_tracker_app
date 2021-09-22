import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class SymptomScreen extends StatelessWidget {
  const SymptomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "Symptoms screen", 
          style: GoogleFonts.lato(
            color: kWhiteColor,
          ),),
      ),
    );
  }
}