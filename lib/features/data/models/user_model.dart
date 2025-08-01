import 'package:expense_tracker/features/domain/entities/user_entity.dart';

class UserModel {
  final String email;
  final String username;

  UserModel({
    required this.email,
    required this.username,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email']?.toString() ?? '', // Handle null values safely
      username: map['username']?.toString() ?? '',
    );
  }
}

extension UserXModel on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      email: email,
      username: username,
    );
  }
}
