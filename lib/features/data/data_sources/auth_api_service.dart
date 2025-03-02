import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:expense_tracker/core/constants/api_urls.dart';
import 'package:expense_tracker/core/network/dio_client.dart';
import 'package:expense_tracker/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/signin_req_params.dart';
import '../models/signup_req_params.dart';

abstract class AuthApiService {
  Future<Either<String, Response>> signup(SignupReqParams signupReq);
  Future<Either<String, Response>> getUser();
  Future<Either<String, Response>> signin(SigninReqParams signinReq);
}

class AuthApiServiceImpl extends AuthApiService {
  @override
  Future<Either<String, Response>> signup(SignupReqParams signupReq) async {
    try {
      var response = await sl<DioClient>().post(
        ApiUrls.register,
        data: signupReq.toMap(),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? "An error occurred");
    }
  }

  @override
  Future<Either<String, Response>> getUser() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('token');
      if (token == null || token.isEmpty) {
        return const Left("User is not authenticated. Please log in.");
      }
      var response = await sl<DioClient>().get(
        ApiUrls.userProfile,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      // Ensure the response data is accessed correctly
      if (response.data is Map<String, dynamic>) {
        return Right(response);
      } else {
        return const Left("Unexpected response format");
      }
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? "An error occurred");
    }
  }

  @override
  Future<Either<String, Response>> signin(SigninReqParams signinReq) async {
    try {
      final response = await sl<DioClient>().post(
        ApiUrls.login,
        data: signinReq.toMap(),
      );

      return Right(response);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? "An error occurred");
    }
  }
}
