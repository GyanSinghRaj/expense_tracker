import 'package:expense_tracker/features/expense/domain/entities/expense.dart';

class ExpenseModel extends Expense {
  final String? billImage;

  ExpenseModel({
    required String id,
    required String userId,
    required String categoryId,
    required double amount,
    required DateTime date,
    required String description,
    this.billImage, // Optional field
  }) : super(
          id: id,
          userId: userId,
          categoryId: categoryId,
          amount: amount,
          date: date,
          description: description,
          billImage: billImage,
        );

  factory ExpenseModel.fromJson(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'],
      userId: json['userId'],
      categoryId: json['categoryId'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      description: json['description'],
      billImage: json['billImage'], // Optional field
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
      'billImage': billImage, // Optional field
    };
  }
}
