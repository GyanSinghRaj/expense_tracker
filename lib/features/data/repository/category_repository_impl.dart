import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:expense_tracker/features/data/data_sources/category_api_service.dart';
import 'package:expense_tracker/features/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryApiService _categoryApiService;

  CategoryRepositoryImpl(this._categoryApiService);

  @override
  Future<Either<String, Response>> getCategories() async {
    return await _categoryApiService.getCategories();
  }

  @override
  Future<Either<String, Response>> addCategory(
      Map<String, dynamic> categoryData) async {
    return await _categoryApiService.addCategory(categoryData);
  }
}
