import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/errors/failures.dart';
import 'package:expense_tracker/core/usecases/usecase.dart';
import 'package:expense_tracker/features/domain/repositories/expense_repository.dart';
import 'package:expense_tracker/locator.dart';


class DeleteExpense implements UseCase<Either<Failure, void>, String> {
  @override
  Future<Either<Failure,void>> call({String? param}) async {
    // Call the deleteExpense method from the repository
    return sl<ExpenseRepository>().deleteExpense(param!);
  }
}