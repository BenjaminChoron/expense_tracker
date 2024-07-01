import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/expenses_list.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Cinema',
      amount: 11.99,
      date: DateTime.now(),
      category: Category.leisure,
    ),
    Expense(
      title: 'Golden Fork',
      amount: 39.60,
      date: DateTime.now(),
      category: Category.food,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Chart'),
        Expanded(
          child: ExpensesList(expenses: _registeredExpenses),
        ),
      ],
    );
  }
}
