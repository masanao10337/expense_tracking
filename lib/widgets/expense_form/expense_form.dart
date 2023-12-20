import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:expense_tracking_app/widgets/expense_form/expense_cateogry_dropdown.dart';
import 'package:expense_tracking_app/widgets/expense_form/expense_date_picker.dart';
import 'package:expense_tracking_app/widgets/expense_form/expense_title_field.dart';
import 'package:expense_tracking_app/widgets/expense_form/expense_amount_field.dart';
import 'package:expense_tracking_app/models/expense.dart';

class ExpneseForm extends StatefulWidget {
  const ExpneseForm({
    required this.addExpense,
    super.key,
  });

  final void Function(Expense expense) addExpense;

  @override
  State<StatefulWidget> createState() => _ExpneseFormState();
}

class _ExpneseFormState extends State<ExpneseForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  final Category _selectedCategory = Category.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submitExpenseData() {
    if (!_validateData()) {
      _presentAlert();
    } else {
      widget.addExpense(
        Expense(
          title: _titleController.text.trim(),
          amount: double.tryParse(_amountController.text)!,
          date: _selectedDate!,
          category: _selectedCategory,
        ),
      );
      Navigator.pop(context);
    }
  }

  //TODO: validatorとかmodelの方に移動したい。
  bool _validateData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final isAmountValid = enteredAmount != null && enteredAmount > 0;
    return _titleController.text.trim().isNotEmpty &&
        isAmountValid &&
        _selectedDate != null;
  }

  void _presentAlert() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
            'Please make sure a valid title, amount, date and category was entered.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
            'Please make sure a valid title, amount, date and category was entered.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
    }
  }

//各種ボタンのモジュール化
  @override
  Widget build(BuildContext context) {
    final double keyBoardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 48, 16, 16 + keyBoardSpace),
            child: Column(
              children: [
                if (width < 600)
                  ExpenseTitleField(titleController: _titleController)
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ExpenseTitleField(
                          titleController: _titleController,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ExpenseAmountField(
                          amountController: _amountController,
                        ),
                      )
                    ],
                  ),
                if (width < 600)
                  Row(
                    children: [
                      Expanded(
                        child: ExpenseAmountField(
                          amountController: _amountController,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: DatePicker(
                          selecteDate: _selectedDate,
                          onDateSelected: (pickedDate) {
                            setState(
                              () {
                                _selectedDate = pickedDate;
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      CategoryDropDown(
                        selectedCategory: _selectedCategory,
                      ),
                      const Spacer(),
                      DatePicker(
                        selecteDate: _selectedDate,
                        onDateSelected: (pickedDate) {
                          setState(
                            () {
                              _selectedDate = pickedDate;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                if (width < 600) const SizedBox(height: 10),
                if (width < 600)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        const SizedBox(width: 5),
                        CategoryDropDown(
                          selectedCategory: _selectedCategory,
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text('Save Expnese'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                      ],
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        const Spacer(),
                        ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text('Save Expnese'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                      ],
                    ),
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}
