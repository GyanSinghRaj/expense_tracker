import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/usecases/usecase.dart';
import 'package:expense_tracker/features/data/models/signup_req_params.dart';
import 'package:expense_tracker/features/domain/repositories/auth_repository.dart';
import 'package:expense_tracker/locator.dart';

class SignupUseCase implements UseCase<Either, SignupReqParams> {
  @override
  Future<Either> call({SignupReqParams? param}) async {
    return sl<AuthRepository>().signup(param!);
  }
}
