import 'package:expense_tracking_app/widgets/chart/chart.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracking_app/widgets/expense_form/expense_form.dart';
import 'package:expense_tracking_app/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracking_app/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.59,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openExpenseFormOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => ExpneseForm(addExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() => _registredExpenses.add(expense));
  }

  void _removeExpense(Expense expense) {
    final int currentIndex = _registredExpenses.indexOf(expense);
    setState(() {
      _registredExpenses.remove(expense);

      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: const Text('Expense deleted.'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () => setState(
              () => _registredExpenses.insert(currentIndex, expense),
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    Widget mainContent = _registredExpenses.isEmpty
        ? const Center(
            child: Text('No expneses. Start adding some!'),
          )
        : ExpensesList(
            expenses: _registredExpenses,
            removeExpense: _removeExpense,
          );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openExpenseFormOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registredExpenses),
                Expanded(child: mainContent),
              ],
            )
          : Row(children: [
              Expanded(child: Chart(expenses: _registredExpenses)),
              Expanded(child: SafeArea(child: mainContent)),
            ]),
    );
  }
}
