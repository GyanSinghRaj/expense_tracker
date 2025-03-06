import 'package:expense_tracker/features/domain/entities/budget_entities.dart';

class BudgetModel extends BudgetEntity {
  BudgetModel({
    required String budgetId,
    required double amount,
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
    required String categoryId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super(
            budgetId: budgetId,
            amount: amount,
            userId: userId,
            startDate: startDate,
            endDate: endDate,
            categoryId: categoryId,
            createdAt: createdAt,
            updatedAt: updatedAt);

  factory BudgetModel.fromMap(Map<String, dynamic> map) {
    return BudgetModel(
      budgetId: map['budgetId']?.toString() ?? "", // Ensure String
      amount: (map['amount'] as num).toDouble(), // Convert int/double safely
      userId: map['userId']?.toString() ?? "", // Ensure String
      startDate:
          DateTime.parse(map['startDate'] ?? ""), // Safe DateTime parsing
      endDate: DateTime.parse(map['endDate'] ?? ""),
      createdAt:
          DateTime.parse(map['createdAt'] ?? ""), // Safe DateTime parsing
      updatedAt:
          DateTime.parse(map['updatedAt'] ?? ""), // Safe DateTime parsing

      categoryId: map['categoryId']?.toString() ?? "", // Ensure String
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
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory BudgetModel.fromJson(Map<String, dynamic> json) {
    return BudgetModel(
      budgetId: json['_id']?.toString() ?? "",
      amount: (json['amount'] as num).toDouble(),
      userId: json['userId']?.toString() ?? "",
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      categoryId: json['categoryId']?.toString() ?? "",
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
      'createdat': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
