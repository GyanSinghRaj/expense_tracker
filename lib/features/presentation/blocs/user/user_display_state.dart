import 'package:expense_tracker/features/data/models/user_model.dart';
import 'package:expense_tracker/features/domain/entities/user_entity.dart';

abstract class UserDisplayState {}

class UserLoading extends UserDisplayState {}

class UserLoaded extends UserDisplayState {
  final UserModel userModel;
  UserLoaded({required this.userModel});
}

class LoadUserFailure extends UserDisplayState {
  final String errorMessage;
  LoadUserFailure({required this.errorMessage});
}
