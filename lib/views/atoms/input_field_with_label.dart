import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class InputFieldWithLabel extends HookWidget {
  const InputFieldWithLabel({
    super.key,
    required this.label,
    required this.initialValue,
    this.onChanged,
    this.onEditingComplete,
    this.width = 100,
  });

  final String label;
  final String initialValue;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label),
        SizedBox(
          width: width,
          child: TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textAlign: TextAlign.center,
            initialValue: initialValue,
            decoration: const InputDecoration(
              isDense: true,
            ),
            onChanged: onChanged,
            onEditingComplete: onEditingComplete,
          ),
        ),
      ],
    );
  }
}
