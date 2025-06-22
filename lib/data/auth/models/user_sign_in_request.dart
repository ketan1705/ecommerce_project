class UserSignInRequest {
  String? email;
  String? password;

  UserSignInRequest({required this.email, this.password});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory UserSignInRequest.fromMap(Map<String, dynamic> map) {
    return UserSignInRequest(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }
}
