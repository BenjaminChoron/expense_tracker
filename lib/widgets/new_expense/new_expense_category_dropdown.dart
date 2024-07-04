import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpenseCategoryDropdown extends StatelessWidget {
  const NewExpenseCategoryDropdown(this._selectCategory, {super.key});

  final void Function(Category) _selectCategory;
  final Category _selectedCategory = Category.leisure;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.secondary),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton(
        value: _selectedCategory,
        items: Category.values
            .map(
              (category) => DropdownMenuItem(
                value: category,
                child: Row(
                  children: [
                    Icon(categoryIcons[category]),
                    const SizedBox(width: 8),
                    Text(category.name.toUpperCase()),
                  ],
                ),
              ),
            )
            .toList(),
        onChanged: (value) => _selectCategory(value!),
        underline: const SizedBox(),
      ),
    );
  }
}
