import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:expense_tracker/core/constants/api_urls.dart';
import 'package:expense_tracker/core/network/dio_client.dart';
import 'package:expense_tracker/features/data/models/budget_model.dart';
import 'package:expense_tracker/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BudgetApiService {
  Future<Either<String, dynamic>> createBudget(BudgetModel budget);
  Future<Either<String, dynamic>> getBudgets();
  Future<Either<String, dynamic>> updateBudget(BudgetModel budget);
  Future<Either<String, dynamic>> deleteBudget(String budgetId);
  Future<Either<String, dynamic>> getBudgetById(String budgetId);
  Future<Either<String, dynamic>> getBudgetByCategory(String categoryId);
}

class BudgetApiServiceImpl extends BudgetApiService {
  Future<String?> _getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  @override
  Future<Either<String, dynamic>> createBudget(BudgetModel budget) async {
    try {
      final token = await _getToken();
      if (token == null) return Left("Token not found");

      final response = await sl<DioClient>().post(
        ApiUrls.createBudget,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: budget.toMap(),
      );

      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? "An error occurred");
    }
  }

  @override
  Future<Either<String, dynamic>> deleteBudget(String budgetId) async {
    try {
      final token = await _getToken();
      if (token == null) return Left("Token not found");

      await sl<DioClient>().delete(
        '${ApiUrls.deleteBudget}/$budgetId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return Right(null);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'An error occurred');
    }
  }

  @override
  Future<Either<String, dynamic>> updateBudget(BudgetModel budget) async {
    try {
      final token = await _getToken();
      if (token == null) return Left("Token not found");

      final response = await sl<DioClient>().put(
        '${ApiUrls.updateBudget}/${budget.budgetId}',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: budget.toMap(),
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'An error occurred');
    }
  }

  @override
  Future<Either<String, dynamic>> getBudgets() async {
    try {
      final token = await _getToken();
      if (token == null) return Left("Token not found");

      final response = await sl<DioClient>().get(
        ApiUrls.getBudgets,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data?['message']?.toString() ??
          e.message ??
          "An error occurred");
    }
  }

  @override
  Future<Either<String, dynamic>> getBudgetById(String budgetId) async {
    try {
      final token = await _getToken();
      if (token == null) return Left("Token not found");

      final response = await sl<DioClient>().get(
        '${ApiUrls.getBudgetById}/$budgetId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'An error occurred');
    }
  }

  @override
  Future<Either<String, dynamic>> getBudgetByCategory(String categoryId) async {
    try {
      final token = await _getToken();
      if (token == null) return Left("Token not found");

      final response = await sl<DioClient>().get(
        '${ApiUrls.getBudgetById}/$categoryId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'An error occurred');
    }
  }
}
