import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/errors/failures.dart';
import 'package:expense_tracker/features/data/data_sources/expense_api_service.dart';
import 'package:expense_tracker/features/data/models/expense_model.dart';
import 'package:expense_tracker/features/domain/repositories/expense_repository.dart';
import 'package:expense_tracker/locator.dart';

class ExpenseRepositoryImpl extends ExpenseRepository {
  final ExpenseApiService expenseApiService = sl<ExpenseApiService>();

  @override
  Future<Either<Failure, ExpenseModel>> createExpense(
      ExpenseModel expense) async {
    try {
      final result = await expenseApiService.createExpense(expense);
      return result.fold(
        (error) => Left(ServerFailure(error)),
        (data) => Right(ExpenseModel.fromJson(data)),
      );
    } catch (e) {
      return Left(ServerFailure('Failed to create expense: $e'));
    }
  }

  @override
  Future<Either<Failure, List<ExpenseModel>>> getExpenses() async {
    try {
      final result = await expenseApiService.getExpenses();
      return result.fold(
        (error) => Left(ServerFailure(error)),
        (data) {
          try {
            if (data is List) {
              final List<ExpenseModel> expenses = data
                  .map((expense) => ExpenseModel.fromJson(expense))
                  .toList();
              return Right(expenses);
            } else {
              return Left(ServerFailure('Response data is not a list'));
            }
          } catch (e) {
            return Left(ServerFailure('Failed to parse expenses: $e'));
          }
        },
      );
    } catch (e) {
      return Left(ServerFailure('Failed to fetch expenses: $e'));
    }
  }

  @override
  Future<Either<Failure, ExpenseModel>> getExpenseById(String expenseId) async {
    try {
      final result = await expenseApiService.getExpenseById(expenseId);
      return result.fold(
        (error) => Left(ServerFailure(error)),
        (data) => Right(ExpenseModel.fromJson(data)),
      );
    } catch (e) {
      return Left(ServerFailure('Failed to fetch expense: $e'));
    }
  }

@override
  Future<Either<Failure, void>> deleteExpense(String expenseId) async {
    try {
      final result = await expenseApiService.deleteExpense(expenseId);
      return result.fold(
        (error) => Left(ServerFailure(error)),
        (_) => const Right(null),
      );
    } catch (e) {
      return Left(ServerFailure('Failed to delete expense: $e'));
    }
  }

  @override
  Future<Either<Failure, ExpenseModel>> updateExpense(
      ExpenseModel expense) async {
    try {
      final result = await expenseApiService.updateExpense(expense);
      return result.fold(
        (error) => Left(ServerFailure(error)),
        (data) => Right(ExpenseModel.fromJson(data)),
      );
    } catch (e) {
      return Left(ServerFailure('Failed to update expense: $e'));
    }
  }
}
