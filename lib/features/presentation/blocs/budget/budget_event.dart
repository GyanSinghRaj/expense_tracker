import 'package:equatable/equatable.dart';
import 'package:expense_tracker/features/data/models/budget_model.dart';

abstract class BudgetEvent extends Equatable {
  const BudgetEvent();

  @override
  List<Object?> get props => [];
}

class LoadBudgetsEvent extends BudgetEvent {}

class AddBudgetEvent extends BudgetEvent {
  final BudgetModel budget;

  const AddBudgetEvent(this.budget);

  @override
  List<Object?> get props => [budget];
}

class UpdateBudgetEvent extends BudgetEvent {
  final BudgetModel budget;

  const UpdateBudgetEvent(this.budget);

  @override
  List<Object?> get props => [budget];
}

class DeleteBudgetEvent extends BudgetEvent {
  final String budgetId;

  const DeleteBudgetEvent(this.budgetId);

  @override
  List<Object?> get props => [budgetId];
}
