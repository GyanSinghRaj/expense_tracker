import 'package:expense_tracker/features/expense/domain/repositories/expense_repository.dart';

class FetchExpenses {
  final ExpenseRepository repository;

  FetchExpenses(this.repository);

  Future<List<Map<String, dynamic>>> call(String userId) {
    return repository.fetchExpenses(userId);
  }
}