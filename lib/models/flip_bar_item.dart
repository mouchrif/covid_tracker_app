import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';

class FlipBarItem {
  final IconData icon;
  final String text;
  final Color frontColor;
  final Color backColor;
  final Color? iconColor;
  final Color? textColor;
  const FlipBarItem({
    required this.icon,
    required this.text,
    required this.backColor,
    required this.frontColor,
    this.iconColor,
    this.textColor,
  });
  static List<FlipBarItem> items = [
    FlipBarItem(
      icon: FontAwesomeIcons.home,
      text: "Home",
      backColor: kPrimaryColor,
      frontColor: kCardColor,
      iconColor: kWhiteColor,
      textColor: kWhiteColor,
    ),
    FlipBarItem(
      icon: FontAwesomeIcons.notesMedical,
      text: "Symptoms",
      backColor: kPrimaryColor,
      frontColor: kCardColor,
      iconColor: kWhiteColor,
      textColor: kWhiteColor,
    ),
    FlipBarItem(
      icon: FontAwesomeIcons.solidClock,
      text: "Live Reports",
      backColor: kPrimaryColor,
      frontColor: kCardColor,
      iconColor: kWhiteColor,
      textColor: kWhiteColor,
    ),
  ];
}
