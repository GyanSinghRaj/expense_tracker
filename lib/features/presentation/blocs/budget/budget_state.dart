import 'package:equatable/equatable.dart';
import 'package:expense_tracker/features/data/models/budget_model.dart';

abstract class BudgetState extends Equatable {
  const BudgetState();

  @override
  List<Object?> get props => [];
}

class BudgetInitialState extends BudgetState {}

class BudgetLoadingState extends BudgetState {}

class BudgetLoadedState extends BudgetState {
  final List<BudgetModel>
      budgets; // Make sure this is BudgetModel not BudgetEntity

  const BudgetLoadedState(this.budgets);

  @override
  List<Object?> get props => [budgets];
}

class BudgetErrorState extends BudgetState {
  final String message;

  const BudgetErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class BudgetAddedState extends BudgetState {
  final BudgetModel budget; // Make sure this is BudgetModel not BudgetEntity

  const BudgetAddedState(this.budget);

  @override
  List<Object?> get props => [budget];
}

class BudgetUpdatedState extends BudgetState {
  final BudgetModel budget; // Make sure this is BudgetModel not BudgetEntity

  const BudgetUpdatedState(this.budget);

  @override
  List<Object?> get props => [budget];
}

class BudgetDeletedState extends BudgetState {
  final String budgetId;

  const BudgetDeletedState(this.budgetId);

  @override
  List<Object?> get props => [budgetId];
}
