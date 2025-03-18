import 'package:flutter/material.dart';

import '../atoms/block.dart';

class ScsvScsv extends StatelessWidget {
  const ScsvScsv({
    super.key,
    required this.blockWidth,
    required this.blockHeight,
    required this.rowCount,
    required this.columnCount,
  });

  final double blockWidth;
  final double blockHeight;
  final int rowCount;
  final int columnCount;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                for (int i = 0; i < rowCount; i++)
                  Row(
                    children: [
                      for (int j = 0; j < columnCount; j++)
                        Block(
                          width: blockWidth,
                          height: blockHeight,
                          x: j / columnCount,
                          y: i / rowCount,
                          text: "$i-$j",
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
