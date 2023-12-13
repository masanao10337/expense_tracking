import 'dart:math';

import 'package:expense_tracking_app/models/expense.dart';

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });
  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    return expenses.fold(0, (sum, expnese) => sum += expnese.amount);
  }
}
