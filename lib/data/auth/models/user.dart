import 'dart:convert';

import 'package:ecommerce/domain/auth/entity/user.dart';

class UserModel {
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String image;
  final int gender;
  final String age;

  UserModel(
      {required this.userId,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.image,
      required this.gender,
      required this.age});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'image': image,
      'gender': gender,
      'age': age
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      image: map['image'] ?? '',
      gender: map['gender'] as int,
      age: map['age'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

extension UserXModel on UserModel {
  UserEntity toEntity() {
    return UserEntity(
        userId: userId,
        firstName: firstName,
        lastName: lastName,
        email: email,
        image: image,
        gender: gender,
        age: age);
  }
}
