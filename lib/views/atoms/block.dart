import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';

class Block extends StatelessWidget {
  const Block({
    super.key,
    required this.width,
    required this.height,
    this.x = 0.0,
    this.y = 0.0,
    this.text,
  });

  final double width;
  final double height;
  final double x;
  final double y;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: HSVColor.fromAHSV(1, 360 * y, x, 1).toColor(),
        border: Border.all(),
      ),
      child: FittedBox(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: text == null
                ? null
                : BorderedText(
                    strokeColor: Colors.white,
                    strokeWidth: 2,
                    child: Text(
                      text!,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
