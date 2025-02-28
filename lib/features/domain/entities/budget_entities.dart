import 'package:expense_tracker/features/data/models/budget_model.dart';

class BudgetEntity {
  final String budgetId;
  final double amount;
  final String userId; // Reference to User
  final DateTime startDate;
  final DateTime endDate;
  final String categoryId;

  BudgetEntity({
    required this.budgetId,
    required this.amount,
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.categoryId,
  });

  factory BudgetEntity.fromJson(Map<String, dynamic> json) {
    return BudgetEntity(
      budgetId: json['budgetId'] ?? '',
      amount: json['amount'] ?? 0.0,
      userId: json['userId'] ?? '',
      startDate: DateTime.tryParse(json['startDate'] ?? '') ?? DateTime.now(),
      endDate: DateTime.tryParse(json['endDate'] ?? '') ?? DateTime.now(),
      categoryId: json['categoryId'] ?? '',
    );
  }

  BudgetEntity copyWith({
    String? budgetId,
    double? amount,
    String? userId,
    DateTime? startDate,
    DateTime? endDate,
    String? categoryId,
  }) {
    return BudgetEntity(
      budgetId: budgetId ?? this.budgetId,
      amount: amount ?? this.amount,
      userId: userId ?? this.userId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      categoryId: categoryId ?? this.categoryId,
    );
  }
}

extension BudgetEntityExtensions on BudgetEntity {
  BudgetModel toModel() {
    return BudgetModel(
      budgetId: budgetId,
      amount: amount,
      userId: userId,
      startDate: startDate,
      endDate: endDate,
      categoryId: categoryId,
    );
  }
}
