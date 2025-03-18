import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:single_scroll_view_test/views/organisms/lv_lv.dart';
import 'package:single_scroll_view_test/views/organisms/lv_scsv.dart';
import 'package:single_scroll_view_test/views/organisms/scsv_lv.dart';

import '../../providers/memory_usage_provider.dart';
import '../atoms/input_field_with_label.dart';
import '../organisms/lvb_lvb.dart';
import '../organisms/scsv_scsv.dart';

class SamplePage extends HookConsumerWidget {
  const SamplePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emoryUsage = ref.watch(memoryUsageProvider);
    final memoryUsageNotifier = ref.watch(memoryUsageProvider.notifier);

    // 定期的にメモリ使用量を取得するためのタイマーを設定
    useEffect(() {
      Timer.periodic(const Duration(seconds: 1), (timer) async {
        final memoryInfo = await developer.Service.getInfo();
        final rss = (ProcessInfo.currentRss / 1000 / 1000)
            .toInt(); // 現在のメモリ使用量 (Resident Set Size)
        memoryUsageNotifier.state = 'RSS ${rss} MB';
      });
      return null; // ウィジェットが破棄された際のクリーンアップは不要
    }, []);

    final visible = useState(true);

    final blockWidth = useState(64.0);
    final blockHeight = useState(64.0);
    final rowCount = useState(100);
    final columnCount = useState(100);

    final blockWidthBuffer = useState(blockWidth.value);
    final blockHeightBuffer = useState(blockHeight.value);
    final rowCountBuffer = useState(rowCount.value);
    final columnCountBuffer = useState(columnCount.value);

    final Map<String, Widget> widgetList = {
      "↕️LV.b & ↔️LV.b": LvbLvb(
        blockWidth: blockWidth.value,
        blockHeight: blockHeight.value,
        rowCount: rowCount.value,
        columnCount: columnCount.value,
      ),
      "↕️LV & ↔️LV": LvLv(
        blockWidth: blockWidth.value,
        blockHeight: blockHeight.value,
        rowCount: rowCount.value,
        columnCount: columnCount.value,
      ),
      "↕️LV & ↔️SCSV": LvScsv(
        blockWidth: blockWidth.value,
        blockHeight: blockHeight.value,
        rowCount: rowCount.value,
        columnCount: columnCount.value,
      ),
      "↕️SCSV & ↔️LV": ScsvLv(
        blockWidth: blockWidth.value,
        blockHeight: blockHeight.value,
        rowCount: rowCount.value,
        columnCount: columnCount.value,
      ),
      "↕️SCSV & ↔️SCSV": ScsvScsv(
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
          title: const Text("SingleChildScrollView vs ListView"),
          centerTitle: false,
          actions: [
            Text(emoryUsage),
            const SizedBox(width: 20),
            InputFieldWithLabel(
              label: "Block width",
              initialValue: "${blockWidth.value.toInt()}",
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
              initialValue: "${blockHeight.value.toInt()}",
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
