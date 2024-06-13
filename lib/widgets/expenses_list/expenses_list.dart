import 'package:flutter/material.dart';
import 'package:proj4_responsive_app/models/expense.dart';
import 'package:proj4_responsive_app/widgets/expenses_list/expenses_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;
  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: expenses.length, //how many things to display in the end
      itemBuilder: (ctx,
              index) => // here index refers to item index in the list
          Dismissible(
              key: ValueKey(
                expenses[index],
              ),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Theme.of(context).colorScheme.error.withOpacity(0.75),
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(
                  horizontal: Theme.of(context).cardTheme.margin!.horizontal,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.remove_circle_outline_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
              onDismissed: (direction) {
                onRemoveExpense(expenses[index]);
              },
              child: ExpensesItem(expenses[index])),
    );
  }
}
