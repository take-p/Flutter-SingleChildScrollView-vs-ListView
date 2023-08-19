import 'package:flutter/material.dart';

class Block extends StatelessWidget {
  const Block({
    super.key,
    required this.width,
    required this.height,
    this.x = 0.0,
    this.y = 0.0,
  });

  final double width;
  final double height;
  final double x;
  final double y;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: HSVColor.fromAHSV(1, 360 * y, x, 1).toColor(),
        border: Border.all(),
      ),
    );
  }
}
