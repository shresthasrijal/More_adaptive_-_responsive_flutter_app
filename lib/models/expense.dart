import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd(); // utility object to help format dates

const uuid = Uuid();

enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.lunch_dining_rounded,
  Category.leisure: Icons.movie_filter,
  Category.travel: Icons.flight_takeoff,
  Category.work: Icons.work,
};

class Expense {
  /* if u have bunch of parameters in class, its better to use named parameters
   instead of positional parameters bc itll be easier to mention them by name
   when creating them rather than knowing their position for each object
   u create
  */
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  /* 
  we dont want to assign unique ids, instead it should be dynamic when created
  It can be done via a third party package - uuid - which u can install with
      ~~ flutter pub add uuid ~~
  */
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;
    for (Expense item in expenses) {
      sum += item.amount;
    }
    return sum;
  }
}
