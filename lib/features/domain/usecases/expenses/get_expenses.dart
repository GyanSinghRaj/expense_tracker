import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/errors/failures.dart';
import 'package:expense_tracker/core/usecases/usecase.dart';
import 'package:expense_tracker/features/data/models/expense_model.dart';
import 'package:expense_tracker/features/domain/repositories/expense_repository.dart';
import 'package:expense_tracker/locator.dart';

class GetExpenses
    implements UseCase<Either<Failure, List<ExpenseModel>>, NoParams> {
  @override
  Future<Either<Failure, List<ExpenseModel>>> call({NoParams? param}) async {
    return sl<ExpenseRepository>().getExpenses();
  }
}
