import 'package:expense_tracker/features/domain/entities/expense_entity.dart';

class ExpenseModel extends ExpenseEntity {
  ExpenseModel({
    required String expenseId,
    required String userId,
    required String categoryId,
    required double amount,
    required DateTime date,
    required String description,
    required String billImage,
    required DateTime createdAt,
    required DateTime updatedAt, // Nullable field
  }) : super(
            expenseId: expenseId,
            userId: userId,
            categoryId: categoryId,
            amount: amount,
            date: date,
            description: description,
            createdAt: createdAt,
            billImage: billImage,
            updatedAt: updatedAt);

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      expenseId: (map['expenseId']) ?? "",
      userId: map['userId'] ?? "",
      categoryId: map['categoryId'] ?? "",
      amount: (map['amount'] as num).toDouble(),
      date: DateTime.parse(map['date'] ?? ""),
      description: map['description'] ?? "",
      billImage: map['billImage'] ?? "", // Nullable field
      createdAt: DateTime.parse(map['createdAt'] ?? ""),
      updatedAt: DateTime.parse(map['updatedAt'] ?? ""),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'expenseId': expenseId,
      'userId': userId,
      'categoryId': categoryId,
      'amount': amount,
      'date': date.toIso8601String(),
      'description': description,
      'billImage': billImage,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      // Nullable field
    };
  }

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      expenseId: json['_id'] ?? "",
      userId: json['userId'] ?? "",
      categoryId: json['categoryId'] ?? "",
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] ?? ""),
      description: json['description'] ?? "",
      createdAt: DateTime.parse(json['createdAt'] ?? ""),
      updatedAt: DateTime.parse(json['updatedAt'] ?? ""),
      billImage: json['billImage'] ?? "", // Nullable field
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'expenseId': expenseId,
      'userId': userId,
      'categoryId': categoryId,
      'amount': amount,
      'date': date.toIso8601String(),
      'description': description,
      'updatedAt': updatedAt,
      "createdAt": createdAt,
      'billImage': billImage, // Nullable field
    };
  }
}
