import 'package:flutter/material.dart';
import 'package:expense_tracking_app/models/expense.dart';
import 'package:expense_tracking_app/widgets/expenses_list/expense_item.dart';

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
      itemBuilder: (ctx, index) => ExpenseItem(expenses[index]),
    );
  }
}
