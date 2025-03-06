import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/usecases/usecase.dart';
import 'package:expense_tracker/features/data/models/budget_model.dart';
import 'package:expense_tracker/features/domain/repositories/budget_repository.dart';

import 'package:expense_tracker/locator.dart';
class CreateBudget implements UseCase<Either, BudgetModel> {
  
  @override
  Future<Either> call({BudgetModel? param}) async {
    // Call the updateBudget method from the repository
    return sl<BudgetRepository>().createBudget(param!);
  }
}
