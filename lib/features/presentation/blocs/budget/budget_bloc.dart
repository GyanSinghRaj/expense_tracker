import 'package:expense_tracker/core/usecases/usecase.dart';
import 'package:expense_tracker/features/domain/usecases/budget/create_budget.dart';
import 'package:expense_tracker/features/domain/usecases/budget/delete_budget.dart';
import 'package:expense_tracker/features/domain/usecases/budget/get_budgets.dart';
import 'package:expense_tracker/features/domain/usecases/budget/update_budget.dart';
import 'package:expense_tracker/features/presentation/blocs/budget/budget_event.dart';
import 'package:expense_tracker/features/presentation/blocs/budget/budget_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  final GetBudgets getBudgets;
  final CreateBudget addBudget;
  final UpdateBudget updateBudget;
  final DeleteBudget deleteBudget;

  BudgetBloc({
    required this.getBudgets,
    required this.addBudget,
    required this.updateBudget,
    required this.deleteBudget,
  }) : super(BudgetInitialState()) {
    // Load budgets
    on<LoadBudgetsEvent>((event, emit) async {
      emit(BudgetLoadingState());

      final result = await getBudgets(param: NoParams());

      result.fold(
        (failure) => emit(BudgetErrorState(failure.message)),
        (budgets) => emit(BudgetLoadedState(budgets)),
      );
    });

    // Add Budget
    on<AddBudgetEvent>((event, emit) async {
      emit(BudgetLoadingState());

      final result = await addBudget(param: event.budget);

      result.fold(
        (failure) => emit(BudgetErrorState(failure.message)),
        (newBudget) {
          emit(BudgetAddedState(newBudget));
          add(LoadBudgetsEvent()); // Reload budgets after adding
        },
      );
    });

    // Update Budget
    on<UpdateBudgetEvent>((event, emit) async {
      emit(BudgetLoadingState());

      final result = await updateBudget(param: event.budget);

      result.fold(
        (failure) => emit(BudgetErrorState(failure.message)),
        (updatedBudget) {
          emit(BudgetUpdatedState(updatedBudget));
          add(LoadBudgetsEvent()); // Reload budgets after updating
        },
      );
    });

    // Delete Budget
    on<DeleteBudgetEvent>((event, emit) async {
      emit(BudgetLoadingState());

      final result = await deleteBudget(param: event.budgetId);

      result.fold(
        (failure) => emit(BudgetErrorState(failure.message)),
        (_) {
          emit(BudgetDeletedState(event.budgetId));
          add(LoadBudgetsEvent()); // Reload budgets after deleting
        },
      );
    });
  }
}
