import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:proj4_responsive_app/models/expense.dart';

import 'dart:io';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
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
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
            title: const Text('Invalid Input'),
            content: const Text(
                'Please make sure a valid title, amount, date and category was entered.'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text('Okay'))
            ]),
      );
    }
    else {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please make sure a valid title, amount, date and category was entered.'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'))
          ]),
      );
    }
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid == true ||
        _selectedDate == null) {
      _showDialog();
      return;
    }
    widget.onAddExpense(Expense(
        title: _titleController.text,
        amount: enteredAmount!,
        date: _selectedDate!,
        category: _selectedCategory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Widget _titleInput() {
    return TextField(
      controller: _titleController,
      maxLength: 50,
      decoration: const InputDecoration(label: Text('Title')),
    );
  }

  Widget _amountInput() {
    return TextField(
      controller: _amountController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        label: Text('Amount'),
        prefixText: '\$',
      ),
    );
  }

  Widget _dropdownInput() {
    return DropdownButton(
      value: _selectedCategory,
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
        if (value == null) {
          return;
        }
        setState(() {
          _selectedCategory = value;
        });
      },
    );
  }

  Widget _dateInput() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(_selectedDate == null
              ? 'No Date Selected'
              : formatter.format(_selectedDate!)),
          IconButton(
              onPressed: _presentDatePicker,
              icon: const Icon(Icons.calendar_month_outlined))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx, constraints) {
      final widthMax = constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace.toInt() + 16),
            child: Column(
              children: [
                if (widthMax >= 600)
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Expanded(child: _titleInput()),
                    const SizedBox(
                      width: 24,
                    ),
                    Expanded(child: _amountInput()),
                  ])
                else
                  _titleInput(),
                if (widthMax >= 600)
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    _dropdownInput(),
                    const Spacer(),
                    _dateInput(),
                  ])
                else
                  Row(
                    children: [
                      Expanded(child: _amountInput()),
                      // add a date input manually
                      const SizedBox(),
                      _dateInput(),
                    ],
                  ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    if (widthMax < 600) _dropdownInput(),
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Discard')),
                    const SizedBox(
                      width: 5,
                    ),
                    ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text('Save')),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
