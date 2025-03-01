import 'package:expense_tracker/core/usecases/usecase.dart';
import 'package:expense_tracker/features/domain/usecases/expenses/create_epense.dart';
import 'package:expense_tracker/features/domain/usecases/expenses/delete_epense.dart';
import 'package:expense_tracker/features/domain/usecases/expenses/get_expenses.dart';
import 'package:expense_tracker/features/domain/usecases/expenses/update_expense.dart';
import 'package:expense_tracker/features/presentation/blocs/expense/expense_event.dart';
import 'package:expense_tracker/features/presentation/blocs/expense/expense_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final GetExpenses getExpenses;
  final CreateExpense addExpense;
  final UpdateExpense updateExpense;
  final DeleteExpense deleteExpense;

  ExpenseBloc({
    required this.getExpenses,
    required this.addExpense,
    required this.updateExpense,
    required this.deleteExpense,
  }) : super(ExpenseInitialState()) {
    // Load expenses
    on<LoadExpensesEvent>((event, emit) async {
      emit(ExpenseLoadingState());

      final result = await getExpenses(param: NoParams());

      result.fold(
        (failure) => emit(ExpenseErrorState(failure.message)),
        (expenses) => emit(ExpenseLoadedState(expenses)),
      );
    });

    // Add Expense
    on<AddExpenseEvent>((event, emit) async {
      emit(ExpenseLoadingState());

      final result = await addExpense(param: event.expense);

      result.fold(
        (failure) => emit(ExpenseErrorState(failure.message)),
        (newExpense) {
          emit(ExpenseAddedState(newExpense));
          add(LoadExpensesEvent()); // Reload expenses after adding
        },
      );
    });

    // Update Expense
    on<UpdateExpenseEvent>((event, emit) async {
      emit(ExpenseLoadingState());

      final result = await updateExpense(param: event.expense);

      result.fold(
        (failure) => emit(ExpenseErrorState(failure.message)),
        (updatedExpense) {
          emit(ExpenseUpdatedState(updatedExpense));
          add(LoadExpensesEvent()); // Reload expenses after updating
        },
      );
    });

    // Delete Expense
    on<DeleteExpenseEvent>((event, emit) async {
      emit(ExpenseLoadingState());

      final result = await deleteExpense(param: event.expenseId);

      result.fold(
        (failure) => emit(ExpenseErrorState(failure.message)),
        (_) {
          emit(ExpenseDeletedState(event.expenseId));
          add(LoadExpensesEvent()); // Reload expenses after deleting
        },
      );
    });
  }
}
