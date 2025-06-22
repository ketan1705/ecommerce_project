class UserCreationRequest {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  int? gender;
  String? age;

  UserCreationRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'gender': gender,
      'age': age,
    };
  }

  factory UserCreationRequest.fromMap(Map<String, dynamic> map) {
    return UserCreationRequest(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }
}
