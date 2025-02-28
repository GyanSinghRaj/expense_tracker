import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:expense_tracker/core/constants/api_urls.dart';
import 'package:expense_tracker/core/network/dio_client.dart';
import 'package:expense_tracker/features/data/models/expese_model.dart';

import 'package:expense_tracker/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ExpenseApiService {
  Future<Either<String, dynamic>> createExpense(ExpenseModel expense);
  Future<Either<String, dynamic>> getExpenses();
  Future<Either<String, dynamic>> updateExpense(ExpenseModel expense);
  Future<Either<String, dynamic>> deleteExpense(String expenseId);
  Future<Either<String, dynamic>> getExpenseById(String expenseId);
}

class ExpenseApiServiceImpl extends ExpenseApiService {
  Future<String?> _getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  @override
  Future<Either<String, dynamic>> createExpense(ExpenseModel expense) async {
    try {
      final token = await _getToken();
      if (token == null) return Left("Token not found");

      final response = await sl<DioClient>().post(
        ApiUrls.createExpense,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: expense.toMap(),
      );

      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? "An error occurred");
    }
  }

  @override
  Future<Either<String, dynamic>> getExpenses() async {
    try {
      final token = await _getToken();
      if (token == null) return Left("Token not found");

      final response = await sl<DioClient>().get(
        ApiUrls.getExpenses,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? "An error occurred");
    }
  }

  @override
  Future<Either<String, dynamic>> updateExpense(ExpenseModel expense) async {
    try {
      final token = await _getToken();
      if (token == null) return Left("Token not found");

      final response = await sl<DioClient>().put(
        '${ApiUrls.updateExpense}/${expense.id}',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: expense.toMap(),
      );

      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? "An error occurred");
    }
  }

  @override
  Future<Either<String, dynamic>> deleteExpense(String expenseId) async {
    try {
      final token = await _getToken();
      if (token == null) return Left("Token not found");

      await sl<DioClient>().delete(
        '${ApiUrls.deleteExpense}/$expenseId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return Right(null);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? "An error occurred");
    }
  }

  @override
  Future<Either<String, dynamic>> getExpenseById(String expenseId) async {
    try {
      final token = await _getToken();
      if (token == null) return Left("Token not found");

      final response = await sl<DioClient>().get(
        '${ApiUrls.getExpenseById}/$expenseId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? "An error occurred");
    }
  }
}