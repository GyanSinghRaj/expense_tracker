import 'package:expense_tracker/features/expense/domain/usecases/fetch_expense.dart';
import 'package:expense_tracker/features/expense/presentation/blocs/expense_event.dart';
import 'package:expense_tracker/features/expense/presentation/blocs/expense_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final FetchExpenses fetchExpenses;

  ExpenseBloc(this.fetchExpenses) : super(ExpenseLoading()) {
    on<FetchExpenseEvent>((event, emit) async {
      emit(ExpenseLoading());
      try {
        final expenses = await fetchExpenses(event.userId);
        emit(ExpenseLoaded(expenses.cast<Map<String, dynamic>>()));
      } catch (e) {
        emit(ExpenseLoading()); // Handle errors properly in production.
      }
    });
  }
}
