import 'dart:io';

import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense/new_expense_category_dropdown.dart';
import 'package:expense_tracker/widgets/new_expense/new_expense_date_picker.dart';
import 'package:expense_tracker/widgets/new_expense/new_expense_actions.dart';
import 'package:expense_tracker/widgets/new_expense/new_expense_amount.dart';
import 'package:expense_tracker/widgets/new_expense/new_expense_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense(this.onAddExpense, {super.key});

  final Function(Expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _selectCategory(value) {
    if (value == null) return;
    setState(() {
      _selectedCategory = value;
    });
  }

  void _showDialog(String dataType) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: Text('Invalid $dataType'),
          content: Text('Please enter a valid $dataType.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Understood'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Invalid $dataType'),
          content: Text('Please enter a valid $dataType.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Understood'),
            ),
          ],
        ),
      );
    }
  }

  void _submitExpenseData() {
    final enteredTitle = _titleController.text.trim();
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsValid = enteredAmount != null && enteredAmount > 0;

    if (enteredTitle.isEmpty) {
      _showDialog('title');
      return;
    }

    if (!amountIsValid) {
      _showDialog('amount');
      return;
    }

    if (_selectedDate == null) {
      _showDialog('date');
      return;
    }

    widget.onAddExpense(
      Expense(
        title: enteredTitle,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'New expense',
                  style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: NewExpenseTitle(_titleController),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: NewExpenseAmount(_amountController),
                      ),
                    ],
                  )
                else
                  NewExpenseTitle(_titleController),
                if (width >= 600)
                  Row(
                    children: [
                      Expanded(
                        child: NewExpenseCategoryDropdown(_selectCategory),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: NewExpenseDatePicker(
                          selectedDate: _selectedDate,
                          presentDatePicker: _presentDatePicker,
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: NewExpenseAmount(_amountController),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: NewExpenseDatePicker(
                          selectedDate: _selectedDate,
                          presentDatePicker: _presentDatePicker,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 20),
                if (width >= 600)
                  NewExpenseActions(_submitExpenseData)
                else
                  Row(
                    children: [
                      NewExpenseCategoryDropdown(_selectCategory),
                      const Spacer(),
                      NewExpenseActions(_submitExpenseData),
                    ],
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}
