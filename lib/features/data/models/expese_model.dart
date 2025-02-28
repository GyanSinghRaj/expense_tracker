import 'package:expense_tracker/features/domain/entities/expense_entity.dart';

class ExpenseModel extends Expense {
  ExpenseModel(
      {required String id,
      required String userId,
      required String categoryId,
      required double amount,
      required DateTime date,
      required String description,
      required String? billImage})
      : super(
            id: id,
            userId: userId,
            categoryId: categoryId,
            amount: amount,
            date: date,
            description: description,
            billImage: billImage);
  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'] as String,
      userId: map['userId'] as String,
      categoryId: map['categoryId'] as String,
      amount: map['amount'] as double,
      date: DateTime.parse(map['date'] as String),
      description: map['description'] as String,
      billImage: map['billImage'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'categoryId': categoryId,
      'amount': amount,
      'date': date.toIso8601String(),
      'description': description,
      'billImage': billImage,
    };
  }

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      categoryId: json['categoryId'] as String,
      amount: json['amount'] as double,
      date: DateTime.parse(json['date'] as String),
      description: json['description'] as String,
      billImage: json['billImage'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'categoryId': categoryId,
      'amount': amount,
      'date': date.toIso8601String(),
      'description': description,
      'billImage': billImage,
    };
  }
}
