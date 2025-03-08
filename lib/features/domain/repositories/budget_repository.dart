import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/errors/failures.dart';
import 'package:expense_tracker/features/data/models/budget_model.dart';

abstract class BudgetRepository {
  Future<Either<Failure, BudgetModel>> createBudget(BudgetModel budget);
  Future<Either<Failure, List<BudgetModel>>> getBudgets();
  Future<Either<Failure, BudgetModel>> getBudgetById(String budgetId);
  Future<Either<Failure, BudgetModel>> updateBudget(BudgetModel Budget);
  Future<Either<Failure, void>> deleteBudget(String budgetId);
  Future<Either<Failure, BudgetModel>> getBudgetByCategory(String categoryId);
}
