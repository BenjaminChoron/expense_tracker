import 'package:flutter/material.dart';

class NewExpenseAmount extends StatelessWidget {
  const NewExpenseAmount(this._amountController, {super.key});

  final TextEditingController _amountController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _amountController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Amount',
        suffixText: '€',
      ),
    );
  }
}
