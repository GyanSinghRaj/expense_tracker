import 'package:dartz/dartz.dart';
import 'package:expense_tracker/core/errors/failures.dart';
import 'package:expense_tracker/core/usecases/usecase.dart';
import 'package:expense_tracker/features/data/models/expense_model.dart';
import 'package:expense_tracker/features/domain/repositories/expense_repository.dart';
import 'package:expense_tracker/locator.dart';

class GetExpenseByCategory
    implements UseCase<Either<Failure, List<ExpenseModel>>, String> {
  @override
  Future<Either<Failure, List<ExpenseModel>>> call({String? param}) async {
    // Call the getExpenseById method from the repository
    return sl<ExpenseRepository>().getExpenseByCategory(param!);
  }
}
