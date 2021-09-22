import 'package:flutter/material.dart';
import 'package:covid_track/models/flip_bar_item.dart';
import 'package:covid_track/widgets/flip_bar_element.dart';

class FlipBoxBar extends StatefulWidget {
  final List<FlipBarItem> items;
  final double navBarHeight;
  final int selectedIndex;
  final Function(int) onIndexChanged;
  FlipBoxBar({
    Key? key,
    required this.items,
    required this.navBarHeight,
    required this.selectedIndex,
    required this.onIndexChanged,
  }) : super(key: key);

  @override
  _FlipBoxBarState createState() => _FlipBoxBarState();
}

class _FlipBoxBarState extends State<FlipBoxBar> with TickerProviderStateMixin {
  List<AnimationController>? controllers = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.items.length; i++) {
      controllers!.add(AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
      ));
    }
    controllers![widget.selectedIndex].forward();
  }

  void _changeValue() {
    controllers!.forEach((controller) {
      if (controller.isCompleted) {
        controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    controllers!.forEach((controller) {
      controller.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.navBarHeight,
      child: Row(
        children: [
          ...List.generate(
            widget.items.length,
            (index) => Expanded(
              child: FlipBarElement(
                icon: widget.items[index].icon,
                text: widget.items[index].text,
                frontColor: widget.items[index].frontColor,
                backColor: widget.items[index].backColor,
                iconColor: widget.items[index].iconColor,
                textColor: widget.items[index].textColor,
                controller: controllers![index],
                appBarHeight: widget.navBarHeight,
                index: index,
                onTapped: (index) {
                  _changeValue();
                  widget.onIndexChanged(index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
