// lib/app/data/models/auth_response_model.dart
import 'user_model.dart';

class AuthResponse {
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final User user;

  AuthResponse({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
    accessToken: json['token'],
    tokenType: json['token_type'],
    expiresIn: json['expires_in'] ?? 36000,
    user: User.fromJson(json['user']),
  );
}
