import 'package:expense_tracker/features/expense/domain/repositories/expense_repository.dart';

class DeleteExpense {
  final ExpenseRepository repository;

  DeleteExpense(this.repository);

  Future<void> call(String userId, String expenseId) {
    return repository.deleteExpense(userId, expenseId);
  }
}