import 'package:expense_tracking_app/models/expense.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DatePicker extends StatefulWidget {
  DatePicker({
    super.key,
    //TODO required検証
    required this.selecteDate,
    required this.onDateSelected,
  });

  DateTime? selecteDate;
  final void Function(DateTime) onDateSelected;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      widget.selecteDate = pickedDate;
    });
    widget.onDateSelected(pickedDate!);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          widget.selecteDate == null
              ? 'date not selected'
              : formatter.format(widget.selecteDate!),
        ),
        IconButton(
          onPressed: _presentDatePicker,
          icon: const Icon(Icons.calendar_month_outlined),
        ),
      ],
    );
  }
}
