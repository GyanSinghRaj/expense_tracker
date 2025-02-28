import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/errors/failures.dart';
import 'package:expense_tracker/features/data/data_sources/budget_api_service.dart';
import 'package:expense_tracker/features/data/models/budget_model.dart';
import 'package:expense_tracker/features/domain/repositories/budget_repository.dart';
import 'package:expense_tracker/locator.dart';

class BudgetRepositoryImpl extends BudgetRepository {
  final BudgetApiService budgetApiService = sl<BudgetApiService>();

  @override
  Future<Either<Failure, BudgetModel>> createBudget(BudgetModel budget) async {
    try {
      final result = await budgetApiService.createBudget(budget);
      return result.fold(
        (error) => Left(ServerFailure(error)),
        (data) => Right(BudgetModel.fromJson(data)),
      );
    } catch (e) {
      return Left(ServerFailure('Failed to create budget: $e'));
    }
  }

  @override
  Future<Either<Failure, List<BudgetModel>>> getBudgets() async {
    try {
      final result = await budgetApiService.getBudgets();
      return result.fold(
        (error) => Left(ServerFailure(error)),
        (data) {
          try {
            if (data is List) {
              final List<BudgetModel> budgets =
                  data.map((budget) => BudgetModel.fromJson(budget)).toList();
              return Right(budgets);
            } else {
              return Left(ServerFailure('Response data is not a list'));
            }
          } catch (e) {
            return Left(ServerFailure('Failed to parse budgets: $e'));
          }
        },
      );
    } catch (e) {
      return Left(ServerFailure('Failed to fetch budgets: $e'));
    }
  }

  @override
  Future<Either<Failure, BudgetModel>> getBudgetById(String budgetId) async {
    try {
      final result = await budgetApiService.getBudgetById(budgetId);
      return result.fold(
        (error) => Left(ServerFailure(error)),
        (data) => Right(BudgetModel.fromJson(data)),
      );
    } catch (e) {
      return Left(ServerFailure('Failed to fetch budget: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBudget(String budgetId) async {
    try {
      final result = await budgetApiService.deleteBudget(budgetId);
      return result.fold(
        (error) => Left(ServerFailure(error)),
        (_) => const Right(null),
      );
    } catch (e) {
      return Left(ServerFailure('Failed to delete budget: $e'));
    }
  }

  @override
  Future<Either<Failure, BudgetModel>> updateBudget(BudgetModel budget) async {
    try {
      final result = await budgetApiService.updateBudget(budget);
      return result.fold(
        (error) => Left(ServerFailure(error)),
        (data) => Right(BudgetModel.fromJson(data)),
      );
    } catch (e) {
      return Left(ServerFailure('Failed to update budget: $e'));
    }
  }
}