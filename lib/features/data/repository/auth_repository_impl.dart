import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/errors/failures.dart';
import 'package:expense_tracker/features/data/data_sources/auth_api_service.dart';
import 'package:expense_tracker/features/data/models/signup_req_params.dart';
import 'package:expense_tracker/features/data/models/user_model.dart';
import 'package:expense_tracker/features/domain/repositories/auth_repository.dart';
import 'package:expense_tracker/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data_sources/auth_local_service.dart';
import '../models/signin_req_params.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either<Failure, void>> signup(SignupReqParams signupReq) async {
    try {
      final result = await sl<AuthApiService>().signup(signupReq);
      return result.fold(
        (error) => Left(ServerFailure(error)),
        (data) async {
          final response = data;
          final sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString('token', response.data['token']);
          return Right(response);
        },
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    return await sl<AuthLocalService>().isLoggedIn();
  }

  @override
  Future<Either<Failure, UserModel>> getUser() async {
    try {
      final result = await sl<AuthApiService>().getUser();
      return result.fold(
        (error) => Left(ServerFailure(error)),
        (data) {
          final response = data;
          if (response.data == null) {
            return Left(ServerFailure("No user data found."));
          }
          if (response.data is! Map<String, dynamic>) {
            return Left(ServerFailure("Unexpected response format"));
          }
          final userModel = UserModel.fromMap(response.data);
          return Right(userModel);
        },
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final result = await sl<AuthLocalService>().logout();
      return result.fold(
        (error) => Left(ServerFailure(error)),
        (_) => const Right(null),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signin(SigninReqParams signinReq) async {
    try {
      final result = await sl<AuthApiService>().signin(signinReq);
      return result.fold(
        (error) => Left(ServerFailure(error)),
        (data) async {
          final response = data;
          final sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString('token', response.data['token']);
          return const Right(null);
        },
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
