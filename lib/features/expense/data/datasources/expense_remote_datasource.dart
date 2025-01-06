abstract class ExpenseRemoteDataSource {
  Future<void> addExpense(String userId, Map<String, dynamic> expenseData);
  Future<List<Map<String, dynamic>>> fetchExpenses(String userId);
  Future<void> updateExpense(
      String userId, String expenseId, Map<String, dynamic> updatedData);
  Future<void> deleteExpense(String userId, String expenseId);
}
