import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MultiDayPicker extends StatefulWidget {
  const MultiDayPicker({super.key, this.onChanged});

  final ValueChanged<List<int>>? onChanged;

  @override
  State<MultiDayPicker> createState() => _MultiDayPickerState();
}

class _MultiDayPickerState extends State<MultiDayPicker> {
  late final List<String> daysOfWeek =
      DateFormat.EEEE(Platform.localeName).dateSymbols.WEEKDAYS;

  late Set<int> selectedDays = {};

  void onSelectDay(int index) {
    final added = selectedDays.add(index);
    if (!added) {
      selectedDays.remove(index);
    }

    widget.onChanged?.call(selectedDays.toList());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: [
        for (var i = 0; i < daysOfWeek.length; i++)
          ChoiceChip(
            selected: selectedDays.contains(i),
            onSelected: (_) => onSelectDay(i),
            label: Text(daysOfWeek[i]),
          ),
      ],
    );
  }
}
