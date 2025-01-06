import 'package:expense_tracker/features/expense/data/datasources/expense_remote_datasource.dart';

abstract class ExpenseRepository {
  Future<void> addExpense(String userId, Map<String, dynamic> expenseData);
  Future<List<Map<String, dynamic>>> fetchExpenses(String userId);
  Future<void> updateExpense(
      String userId, String expenseId, Map<String, dynamic> updatedData);
  Future<void> deleteExpense(String userId, String expenseId);
}

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseRemoteDataSource remoteDataSource;

  ExpenseRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> addExpense(String userId, Map<String, dynamic> expenseData) {
    return remoteDataSource.addExpense(userId, expenseData);
  }

  @override
  Future<List<Map<String, dynamic>>> fetchExpenses(String userId) {
    return remoteDataSource.fetchExpenses(userId);
  }

  @override
  Future<void> updateExpense(
      String userId, String expenseId, Map<String, dynamic> updatedData) {
    return remoteDataSource.updateExpense(userId, expenseId, updatedData);
  }

  @override
  Future<void> deleteExpense(String userId, String expenseId) {
    return remoteDataSource.deleteExpense(userId, expenseId);
  }
}
