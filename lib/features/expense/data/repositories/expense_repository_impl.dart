import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/features/expense/data/datasources/expense_remote_datasource.dart';

class ExpenseRemoteDataSourceImpl implements ExpenseRemoteDataSource {
  final FirebaseFirestore firestore;

  ExpenseRemoteDataSourceImpl(this.firestore);

  @override
  Future<void> addExpense(
      String userId, Map<String, dynamic> expenseData) async {
    await firestore
        .collection('users')
        .doc(userId)
        .collection('expenses')
        .add(expenseData);
  }

  @override
  Future<List<Map<String, dynamic>>> fetchExpenses(String userId) async {
    final querySnapshot = await firestore
        .collection('users')
        .doc(userId)
        .collection('expenses')
        .get();
    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();
  }

  @override
  Future<void> updateExpense(
      String userId, String expenseId, Map<String, dynamic> updatedData) async {
    await firestore
        .collection('users')
        .doc(userId)
        .collection('expenses')
        .doc(expenseId)
        .update(updatedData);
  }

  @override
  Future<void> deleteExpense(String userId, String expenseId) async {
    await firestore
        .collection('users')
        .doc(userId)
        .collection('expenses')
        .doc(expenseId)
        .delete();
  }
}
