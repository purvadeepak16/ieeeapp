class UserModel {
  final String name;
  final String email;
  final String phone;
  final String? photoPath; // profile image path (nullable)

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    this.photoPath,
  });

  /// Creates a new UserModel with updated fields
  UserModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? photoPath,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      photoPath: photoPath ?? this.photoPath,
    );
  }
}
