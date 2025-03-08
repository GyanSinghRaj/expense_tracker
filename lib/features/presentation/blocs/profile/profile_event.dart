abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  final String name;
  final String email;

  UpdateProfile({required this.name, required this.email});
}

class LogoutUser extends ProfileEvent {}
