import 'package:flutter/material.dart';

class NewExpenseTitle extends StatelessWidget {
  const NewExpenseTitle(this._titleController, {super.key});

  final TextEditingController _titleController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _titleController,
      maxLength: 25,
      decoration: const InputDecoration(labelText: 'Title'),
    );
  }
}
