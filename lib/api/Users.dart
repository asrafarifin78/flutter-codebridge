import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  final int userId;
  final int email;
  final String password;

  const User({
    required this.userId,
    required this.email,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'userId': int userId,
        'email': int email,
        'password': String password,
      } =>
        User(
          userId: userId,
          email: email,
          password: password,
        ),
      _ => throw const FormatException('Failed to load User.'),
    };
  }
}
