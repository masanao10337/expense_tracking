import 'package:flutter/material.dart';

class ExpenseTitleField extends StatelessWidget {
  const ExpenseTitleField({
    super.key,
    required this.titleController,
  });

  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: titleController,
      maxLength: 50,
      decoration: const InputDecoration(label: Text('Title')),
    );
  }
}
