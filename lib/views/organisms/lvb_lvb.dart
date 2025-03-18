import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

import '../atoms/block.dart';

class LvbLvb extends HookWidget {
  const LvbLvb({
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
    final horizontalControllers = useState(LinkedScrollControllerGroup());
    final List<ValueNotifier<ScrollController>> controllerList = [];
    for (int i = 0; i < rowCount; i++) {
      controllerList.add(useState(horizontalControllers.value.addAndGet()));
    }

    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      itemCount: rowCount,
      itemBuilder: (context, index) {
        return SizedBox(
          height: blockHeight,
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            controller: controllerList[index].value,
            scrollDirection: Axis.horizontal,
            itemCount: columnCount,
            itemBuilder: (context, columnIndex) {
              return SizedBox(
                width: blockWidth,
                height: blockHeight,
                child: Block(
                  width: blockWidth,
                  height: blockHeight,
                  x: columnIndex / columnCount,
                  y: index / rowCount,
                  text: "$index-$columnIndex",
                ),
              );
            },
          ),
        );
      },
    );
  }
}
