import 'package:expense_tracker/features/user/domain/repositories/AuthRepository.dart';

class Logout{
  final AuthRepository repository;

  Logout(this.repository);

  Future<void> call() async {
    return await repository.logout();
  }
}