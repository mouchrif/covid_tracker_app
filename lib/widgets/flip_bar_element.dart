import 'package:covid_track/widgets/back_child.dart';
import 'package:covid_track/widgets/flip_box.dart';
import 'package:covid_track/widgets/front_child.dart';
import 'package:flutter/material.dart';

class FlipBarElement extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color backColor;
  final Color frontColor;
  final Color? iconColor;
  final Color? textColor;
  final AnimationController controller;
  final double appBarHeight;
  final Function(int) onTapped;
  final int index;

  FlipBarElement({
    Key? key,
    required this.icon,
    required this.text,
    required this.frontColor,
    required this.backColor,
    this.iconColor,
    this.textColor,
    required this.controller,
    required this.appBarHeight,
    required this.onTapped,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlipBox(
      frontChild: FrontChild(icon: icon, text: text, frontColor: frontColor, iconColor: iconColor, textColor: textColor),
      backChild: BackChild(icon: icon, backColor: backColor, iconColor: iconColor),
      controller: controller,
      onTapped: () {
        onTapped(index);
      },
      height: appBarHeight,
    );
  }
}
