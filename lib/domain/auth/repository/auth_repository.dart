import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/auth/models/user_creation_request.dart';
import 'package:ecommerce/data/auth/models/user_sign_in_request.dart';

abstract class AuthRepository {
  Future<Either> signUp(UserCreationRequest user);

  Future<Either> signIn(UserSignInRequest user);

  Future<Either> getAges();

  Future<Either> sendPasswordResetEmail(String email);

  Future<bool> isLoggedIn();

  Future<Either> getUser();
}
