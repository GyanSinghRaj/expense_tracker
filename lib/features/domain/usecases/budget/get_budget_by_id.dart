import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/errors/failures.dart';
import 'package:expense_tracker/core/usecases/usecase.dart';
import 'package:expense_tracker/features/data/models/budget_model.dart';
import 'package:expense_tracker/features/domain/repositories/budget_repository.dart';

import 'package:expense_tracker/locator.dart';

class GetBudgetById implements UseCase<Either<Failure, BudgetModel>, String> {
  @override
  Future<Either<Failure, BudgetModel>> call({String? param}) async {
    // Call the getBudgetById method from the repository
    return sl<BudgetRepository>().getBudgetById(param!);
  }
}
