import 'package:expense_tracker/features/expense/domain/repositories/expense_repository.dart';

class UpdateExpense {
  final ExpenseRepository repository;

  UpdateExpense(this.repository);

  Future<void> call(
      String userId, String expenseId, Map<String, dynamic> updatedData) {
    return repository.updateExpense(userId, expenseId, updatedData);
  }
}
