import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:expense_tracker/core/constants/api_urls.dart';
import 'package:expense_tracker/core/network/dio_client.dart';
import 'package:expense_tracker/locator.dart';

abstract class CategoryApiService {
  Future<Either<String, Response>> getCategories();
  Future<Either<String, Response>> addCategory(Map<String, dynamic> categoryData);
}

class CategoryApiServiceImpl implements CategoryApiService {
  @override
  Future<Either<String, Response>> getCategories() async {
    try {
      final response = await sl<DioClient>().get(ApiUrls.getCategories);
      if (response.data is List) {
        return Right(response);
      } else {
        return const Left("Unexpected response format");
      }
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? "An error occurred");
    }
  }

  @override
  Future<Either<String, Response>> addCategory(Map<String, dynamic> categoryData) async {
    try {
      final response = await sl<DioClient>().post(ApiUrls.getCategories, data: categoryData);
      if (response.data is Map<String, dynamic>) {
        return Right(response);
      } else {
        return const Left("Unexpected response format");
      }
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? "An error occurred");
    }
  }
}