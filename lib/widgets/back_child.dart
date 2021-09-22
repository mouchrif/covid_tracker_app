import 'package:flutter/material.dart';

class BackChild extends StatelessWidget {
  final IconData icon;
  final Color backColor;
  final Color? iconColor;
  const BackChild({Key? key, required this.icon, required this.backColor, this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: backColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 20.0,
          ),
        ],
      ),
    );
  }
}
