class BudgetEntity {
  final String budgetId;
  final double amount;
  final String userId; // Reference to User
  final DateTime startDate;
  final DateTime endDate;
  final String categoryId;
  final DateTime createdAt;
  final DateTime updatedAt;

  BudgetEntity({
    required this.budgetId,
    required this.amount,
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
  });

//   factory BudgetEntity.fromJson(Map<String, dynamic> json) {
//     return BudgetEntity(
//       budgetId: json['budgetId'] ?? '',
//       amount: json['amount'] ?? 0.0,
//       userId: json['userId'] ?? '',
//       startDate: DateTime.tryParse(json['startDate'] ?? '') ?? DateTime.now(),
//       endDate: DateTime.tryParse(json['endDate'] ?? '') ?? DateTime.now(),
//       categoryId: json['categoryId'] ?? '',
//       updatedAt: DateTime.tryParse(json['updateAt'] ?? '') ?? DateTime.now(),
//       createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
//     );
//   }

//   BudgetEntity copyWith({
//     String? budgetId,
//     double? amount,
//     String? userId,
//     DateTime? startDate,
//     DateTime? endDate,
//     String? categoryId,
//     DateTime? createdAT,
//     DateTime? updatedAt,
//   }) {
//     return BudgetEntity(
//         budgetId: budgetId ?? this.budgetId,
//         amount: amount ?? this.amount,
//         userId: userId ?? this.userId,
//         startDate: startDate ?? this.startDate,
//         endDate: endDate ?? this.endDate,
//         categoryId: categoryId ?? this.categoryId,
//         updatedAt: updatedAt ?? this.updatedAt,
//         createdAt: createdAt ?? this.createdAt);
//   }
// }

// extension BudgetEntityExtensions on BudgetEntity {
//   BudgetModel toModel() {
//     return BudgetModel(
//       budgetId: budgetId,
//       amount: amount,
//       userId: userId,
//       startDate: startDate,
//       endDate: endDate,
//       createdAt: createdAt,
//       updatedAt: updatedAt,
//       categoryId: categoryId,
//     );
//   }
}
