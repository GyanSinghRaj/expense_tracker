class User {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final String? phoneNumber;
  final String? address;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    this.phoneNumber,
    this.address, required String password, required String fullName,
  });

  List<Object?> get props => [id, name, email, photoUrl, phoneNumber, address];
}
