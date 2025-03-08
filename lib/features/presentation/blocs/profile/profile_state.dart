abstract class ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String name;
  final String email;
  final String profilePic;
  final double totalExpenses;
  final double monthlyBudget;

  ProfileLoaded({
    required this.name,
    required this.email,
    required this.profilePic,
    required this.totalExpenses,
    required this.monthlyBudget,
  });
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
