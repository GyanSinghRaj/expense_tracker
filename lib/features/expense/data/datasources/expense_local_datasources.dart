abstract class ExpenseLocalDatasources {
  Future<List<Map<String, dynamic>>> getExpenses();
  Future<void> createExpense(Map<String, dynamic> expense);
  Future<void> deleteExpenseById(String id);
  Future<void> updateExpense(Map<String, dynamic> expense);
}

class ExpenseLocalDatasourcesImpl implements ExpenseLocalDatasources {
  final database;

  final List<Map<String, dynamic>> _expenseDatabase = [];

  ExpenseLocalDatasourcesImpl({required this.database});

  Future<List<Map<String, dynamic>>> getExpenses() async {
    // Explicitly cast the list to List<Map<String, dynamic>>
    return _expenseDatabase.cast<Map<String, dynamic>>();
  }

  @override
  Future<void> createExpense(Map<String, dynamic> expense) async {
    await database.insert('expenses', expense);
  }

  @override
  Future<void> deleteExpenseById(String id) async {
    await database.delete('expenses', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> updateExpense(Map<String, dynamic> expense) async {
    await database.update('expenses', expense,
        where: 'id = ?', whereArgs: [expense['id']]);
  }
}
