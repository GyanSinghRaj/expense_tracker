import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/errors/failures.dart';
import 'package:expense_tracker/features/data/models/expense_model.dart';

abstract class ExpenseRepository {
  Future<Either<Failure, ExpenseModel>> createExpense(ExpenseModel budget);
  // Future<Either<Failure, dynamic>> getExpenses();
  Future<Either<Failure, List<ExpenseModel>>> getExpenses();
  Future<Either<Failure, ExpenseModel>> getExpenseById(String budgetId);
  Future<Either<Failure, ExpenseModel>> updateExpense(ExpenseModel expense);
  Future<Either<Failure, void>> deleteExpense(String budgetId);
  Future<Either<Failure, List<ExpenseModel>>> getExpenseByCategory(
      String categoryId);
}
