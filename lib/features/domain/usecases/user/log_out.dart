import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/usecases/usecase.dart';
import 'package:expense_tracker/features/domain/repositories/auth_repository.dart';
import 'package:expense_tracker/locator.dart';

class LogoutUseCase implements UseCase<Either, dynamic> {

  @override
  Future<Either> call({param}) async {
    return await sl<AuthRepository>().logout();
  }

}