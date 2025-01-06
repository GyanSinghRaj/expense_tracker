import 'package:expense_tracker/features/user/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required String id,
    required String email,
    required String password,
    required String fullName,
    required String name,
  }) : super(
          id: id,
          email: email,
          password: password,
          fullName: fullName,
          name: name,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      fullName: json['fullName'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
    };
  }
}
