import 'package:expense_tracker/features/expense/domain/repositories/expense_repository.dart';

class AddExpense {
  final ExpenseRepository repository;

  AddExpense(this.repository);

  Future<void> call(String userId, Map<String, dynamic> expenseData) {
    return repository.addExpense(userId, expenseData);
  }
}
