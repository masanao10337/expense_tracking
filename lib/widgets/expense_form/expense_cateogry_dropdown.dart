import 'package:flutter/material.dart';
import 'package:expense_tracking_app/models/expense.dart';

// ignore: must_be_immutable
class CategoryDropDown extends StatefulWidget {
  CategoryDropDown({
    super.key,
    required this.selectedCategory,
  });

  Category selectedCategory;

  @override
  State<CategoryDropDown> createState() => _CategoryDropDownState();
}

class _CategoryDropDownState extends State<CategoryDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      borderRadius: BorderRadius.circular(12),
      value: widget.selectedCategory,
      items: Category.values
          .map(
            (category) => DropdownMenuItem(
              value: category,
              child: Text(
                category.name.toUpperCase(),
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value == null) return;

        setState(() {
          widget.selectedCategory = value;
        });
      },
    );
  }
}
