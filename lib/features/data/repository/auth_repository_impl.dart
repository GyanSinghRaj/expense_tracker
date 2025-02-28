import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
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
  Future<Either> signup(SignupReqParams signupReq) async {
    Either result = await sl<AuthApiService>().signup(signupReq);
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('token', response.data['token']);
      return Right(response);
    });
  }

  @override
  Future<bool> isLoggedIn() async {
    return await sl<AuthLocalService>().isLoggedIn();
  }

  @override
  Future<Either> getUser() async {
    Either result = await sl<AuthApiService>().getUser();
    return result.fold((error) {
      return Left(error);
    }, (data) {
      Response response = data;
      if (response.data == null) {
        return Left("No user data found.");
      }

      var userModel = UserModel.fromMap(response.data);
      return Right(userModel.toEntity());
    });
  }

  @override
  Future<Either> logout() async {
    return await sl<AuthLocalService>().logout();
  }

  @override
  Future<Either> signin(SigninReqParams signinReq) async {
    Either result = await sl<AuthApiService>().signin(signinReq);
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('token', response.data['token']);
      return Right(response);
    });
  }
}
