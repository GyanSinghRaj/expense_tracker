
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class CategoryRepository {
  Future<Either<String, Response>> getCategories();
  Future<Either<String, Response>> addCategory(Map<String, dynamic> categoryData);
}