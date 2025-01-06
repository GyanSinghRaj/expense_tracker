class Budget {
  final String id;
  final double amount;
  final String userId; // Reference to User

  final DateTime startDate;
  final DateTime endDate;
  
  final String categoryId;

  Budget({
    required this.id,
    required this.amount,
    required this.userId,
    required this.startDate,
    required this.categoryId,
    required this.endDate,
  });
}