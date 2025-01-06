class ExpenseEvent {}

class FetchExpenseEvent extends ExpenseEvent {
  final String userId;

  FetchExpenseEvent(this.userId);
}
