import 'package:flutter/material.dart';
import 'package:expense_tracking_app/models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
  });

  final List<Expense> expenses;
  // TODO: itemBuilderを関数で切り分ける。
  // Widget? Function(BuildContext, int) makeItems;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Text(expenses[index].title),
    );
  }
}
