class Expense {
  final String id;
  final String userId;
  final String categoryId;
  final double amount;
  final DateTime date;
  final String description;
  final String? billImage;

  Expense({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.amount,
    required this.date,
    required this.description,
    this.billImage,
  });
  
}
