import 'package:flutter/material.dart';

class ExpenseAmountField extends StatelessWidget {
  const ExpenseAmountField({
    super.key,
    required this.amountController,
  });

  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: amountController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        prefixText: '\$ ',
        label: Text('Amount'),
      ),
    );
  }
}
