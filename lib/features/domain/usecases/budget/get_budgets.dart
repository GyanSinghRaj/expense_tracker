import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/usecases/usecase.dart';
import 'package:expense_tracker/features/domain/repositories/budget_repository.dart';

import 'package:expense_tracker/locator.dart';
class GetBudgets implements UseCase<Either, void> {
  @override
  Future<Either> call({void param}) async {
    return sl<BudgetRepository>().getBudgets();
  }
}
