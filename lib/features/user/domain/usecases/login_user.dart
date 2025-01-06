import 'package:expense_tracker/features/user/domain/repositories/AuthRepository.dart';

class Login{
  final AuthRepository repository;
  Login(this.repository);
  Future<String> call(String email, String password) async {
    return await repository.login(email, password);
  }
}