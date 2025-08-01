import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/usecases/usecase.dart';
import 'package:expense_tracker/features/data/models/expense_model.dart';
import 'package:expense_tracker/features/domain/repositories/expense_repository.dart';
import 'package:expense_tracker/locator.dart';

class UpdateExpense implements UseCase<Either, ExpenseModel> {
  @override
  Future<Either> call({ExpenseModel? param}) async {
    // Call the updateExpense method from the repository
    return sl<ExpenseRepository>().updateExpense(param!);
  }
}
