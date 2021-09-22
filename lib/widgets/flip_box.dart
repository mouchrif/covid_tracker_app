import 'package:flutter/material.dart';
import 'dart:math' as math;

class FlipBox extends StatefulWidget {
  final Widget frontChild;
  final Widget backChild;
  final double height;
  final AnimationController controller;
  final VoidCallback onTapped;
  FlipBox({
    Key? key,
    required this.frontChild,
    required this.backChild,
    required this.height,
    required this.controller,
    required this.onTapped,
  }) : super(key: key);

  @override
  _FlipBoxState createState() => _FlipBoxState();
}

class _FlipBoxState extends State<FlipBox> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation? animation;

  void _listeneble() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
    animation = Tween(begin: 0, end: math.pi / 2).animate(CurvedAnimation(
      parent: controller!,
      curve: Curves.elasticInOut,
    ));
    controller!.addListener(_listeneble);
  }

  @override
  void dispose() {
    controller!.dispose();
    controller!.removeListener(_listeneble);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: widget.height,
      child: Stack(
        children: [
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..translate(
                0.0,
                -(widget.height / 2 * math.cos(animation!.value)),
                -(widget.height / 2 * math.sin(animation!.value)),
              )
              ..rotateX((-math.pi / 2) + animation!.value),
            child: widget.backChild,
          ),
          GestureDetector(
            onTap: () {
              widget.onTapped();
              controller!.forward();
            },
            child: animation!.value < 85 * math.pi / 180
                ? Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..translate(
                        0.0,
                        widget.height / 2 * math.sin(animation!.value),
                        -(widget.height / 2 * math.cos(animation!.value)),
                      )
                      ..rotateX(animation!.value.toDouble()),
                    child: widget.frontChild,
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
