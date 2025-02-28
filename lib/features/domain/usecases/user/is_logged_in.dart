import 'package:expense_tracker/core/usecases/usecase.dart';
import 'package:expense_tracker/features/domain/repositories/auth_repository.dart';
import 'package:expense_tracker/locator.dart';

class IsLoggedInUseCase implements UseCase<bool, dynamic> {
  @override
  Future<bool> call({dynamic param}) async {
    return sl<AuthRepository>().isLoggedIn();
  }
}