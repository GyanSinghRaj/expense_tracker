import 'package:expense_tracker/features/domain/entities/budget_entities.dart';

class BudgetModel extends BudgetEntity {
  BudgetModel({
    required String budgetId,
    required double amount,
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
    required String categoryId,
  }) : super(
          budgetId: budgetId,
          amount: amount,
          userId: userId,
          startDate: startDate,
          endDate: endDate,
          categoryId: categoryId,
        ) {}

  factory BudgetModel.fromMap(Map<String, dynamic> map) {
    return BudgetModel(
     budgetId: map['budgetId'] as String,
      amount: map['amount'] as double,
      userId: map['userId'] as String,
      startDate: DateTime.parse(map['startDate'] as String),
      endDate: DateTime.parse(map['endDate'] as String),
      categoryId: map['categoryId'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'budgetId': budgetId,
      'amount': amount,
      'userId': userId,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'categoryId': categoryId,
    };
  }

  factory BudgetModel.fromJson(Map<String, dynamic> json) {
    return BudgetModel(
      budgetId: json['budgetId'] as String,
      amount: json['amount'] as double,
      userId: json['userId'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      categoryId: json['categoryId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'budgetId': budgetId,
      'amount': amount,
      'userId': userId,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'categoryId': categoryId,
    };
  }
}
