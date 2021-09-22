import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FrontChild extends StatelessWidget {
  final IconData icon;
  final Color frontColor;
  final String text;
  final Color? iconColor;
  final Color? textColor;
  const FrontChild(
      {Key? key,
      required this.icon,
      required this.frontColor,
      required this.text,
      this.iconColor,
      this.textColor,
    })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: frontColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 18.0,
          ),
          SizedBox(height: 6),
          Text(
            text,
            style: GoogleFonts.lato(
              color: textColor,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}
