import 'package:expense_tracker/features/user/data/datasources/auth_remote_datasource.dart';
import 'package:expense_tracker/features/user/domain/repositories/AuthRepository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<String> login(String email, String password) {
    return remoteDataSource.login(email, password);
  }

  @override
  Future<void> logout() {
    return remoteDataSource.logout();
  }
}
