import 'package:expense_tracker/features/domain/entities/user_entity.dart';

class UserModel {
  // final String id;
  final String email;
  final String username;

  UserModel(
      {
      // required this.id,
      required this.email,
      required this.username});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      // id: map['_id'] as String,
      email: map['email'] as String,
      username: map['username'] as String,
    );
  }
}

extension UserXModel on UserModel {
  UserEntity toEntity() {
    return UserEntity(
        // id: id.toString(),
        email: email.toString(),
        username: username.toString());
  }
}
