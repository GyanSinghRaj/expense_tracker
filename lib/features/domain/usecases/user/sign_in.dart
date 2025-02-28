import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/usecases/usecase.dart';
import 'package:expense_tracker/features/data/models/signin_req_params.dart';
import 'package:expense_tracker/features/domain/repositories/auth_repository.dart';
import 'package:expense_tracker/locator.dart';

class SigninUseCase implements UseCase<Either, SigninReqParams> {
  @override
  Future<Either> call({SigninReqParams? param}) async {
    return sl<AuthRepository>().signin(param!);
  }
}