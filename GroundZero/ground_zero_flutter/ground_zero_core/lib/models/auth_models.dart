class AuthResponse {
  final String token;
  final String email;
  final String userId;
  AuthResponse({required this.token, required this.email, required this.userId});
  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
    AuthResponse(token: json['token'], email: json['email'], userId: json['userId']);
}

class LoginRequest {
  final String email; final String password;
  LoginRequest({required this.email, required this.password});
  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}

class RegisterRequest {
  final String email; final String password;
  RegisterRequest({required this.email, required this.password});
  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}