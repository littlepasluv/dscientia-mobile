import '../../domain/entities/user.dart';

class UserModel {
  final String id;
  final String email;
  final String fullName;
  final String role;
  final bool isEmailVerified;
  final DateTime createdAt;

  const UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
    required this.isEmailVerified,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['full_name'] as String,
      role: json['role'] as String,
      isEmailVerified: json['is_email_verified'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  User toEntity() {
    return User(
      id: id,
      email: email,
      fullName: fullName,
      role: role,
      isEmailVerified: isEmailVerified,
      createdAt: createdAt,
    );
  }
}