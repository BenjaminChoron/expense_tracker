import 'package:flutter/material.dart';

class NewExpenseActions extends StatelessWidget {
  const NewExpenseActions(this.onSubmit, {super.key});

  final Function() onSubmit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: onSubmit,
          child: const Text('Add Expense'),
        ),
      ],
    );
  }
}
