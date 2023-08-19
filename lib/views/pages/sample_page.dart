import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:single_scroll_view_test/views/organisms/scsv_sv.dart';
import 'package:single_scroll_view_test/views/organisms/sv_scsv.dart';

import '../atoms/input_field_with_label.dart';
import '../organisms/scsv_scsv.dart';
import '../organisms/sv_sv.dart';

class SamplePage extends HookWidget {
  const SamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    final visible = useState(true);

    final blockWidth = useState(32.0);
    final blockHeight = useState(32.0);
    final rowCount = useState(100);
    final columnCount = useState(100);

    final blockWidthBuffer = useState(blockWidth.value);
    final blockHeightBuffer = useState(blockHeight.value);
    final rowCountBuffer = useState(rowCount.value);
    final columnCountBuffer = useState(columnCount.value);

    final Map<String, Widget> widgetList = {
      "↕️SCSV & ↔️SCSV": ScsvScsv(
        blockWidth: blockWidth.value,
        blockHeight: blockHeight.value,
        rowCount: rowCount.value,
        columnCount: columnCount.value,
      ),
      "↕️SCSV & ↔️SV": ScsvSv(
        blockWidth: blockWidth.value,
        blockHeight: blockHeight.value,
        rowCount: rowCount.value,
        columnCount: columnCount.value,
      ),
      "↕️SV & ↔️SCSV": SvScsv(
        blockWidth: blockWidth.value,
        blockHeight: blockHeight.value,
        rowCount: rowCount.value,
        columnCount: columnCount.value,
      ),
      "↕️SV & ↔️SV": SvSv(
        blockWidth: blockWidth.value,
        blockHeight: blockHeight.value,
        rowCount: rowCount.value,
        columnCount: columnCount.value,
      ),
    };

    void reload() {
      blockWidth.value = blockWidthBuffer.value;
      blockHeight.value = blockHeightBuffer.value;
      rowCount.value = rowCountBuffer.value;
      columnCount.value = columnCountBuffer.value;
    }

    return DefaultTabController(
      length: widgetList.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("SingleChildScrollView vs ScrollView"),
          centerTitle: false,
          actions: [
            InputFieldWithLabel(
              label: "Block width",
              initialValue: "32",
              onChanged: (value) {
                blockWidthBuffer.value = double.parse(value);
              },
              onEditingComplete: () {
                reload();
              },
              width: 50,
            ),
            const SizedBox(width: 20),
            InputFieldWithLabel(
              label: "Block height",
              initialValue: "32",
              onChanged: (value) {
                blockHeightBuffer.value = double.parse(value);
              },
              onEditingComplete: () {
                reload();
              },
              width: 50,
            ),
            const SizedBox(width: 20),
            InputFieldWithLabel(
              label: "Row",
              initialValue: rowCount.value.toString(),
              onChanged: (value) {
                rowCountBuffer.value = int.parse(value);
              },
              onEditingComplete: () {
                reload();
              },
              width: 50,
            ),
            const SizedBox(width: 20),
            InputFieldWithLabel(
              label: "Column",
              initialValue: columnCount.value.toString(),
              onChanged: (value) {
                columnCountBuffer.value = int.parse(value);
              },
              onEditingComplete: () {
                reload();
              },
              width: 50,
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                reload();
              },
              child: const Text("Reload"),
            ),
            const SizedBox(width: 20),
          ],
          bottom: TabBar(
            tabs: widgetList.keys.map((e) => Tab(text: e)).toList(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            visible.value = !visible.value;
          },
          child: Icon(
            visible.value ? Icons.visibility : Icons.visibility_off,
          ),
        ),
        body: visible.value
            ? TabBarView(
                children: widgetList.values.toList(),
              )
            : null,
      ),
    );
  }
}
