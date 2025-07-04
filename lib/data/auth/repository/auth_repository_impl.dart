import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/auth/models/user.dart';
import 'package:ecommerce/data/auth/models/user_creation_request.dart';
import 'package:ecommerce/data/auth/models/user_sign_in_request.dart';
import 'package:ecommerce/data/auth/source/auth_firebase_service.dart';
import 'package:ecommerce/domain/auth/repository/auth_repository.dart';

import '../../../service_locator.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either> signUp(UserCreationRequest user) async {
    return await sl<AuthFirebaseService>().signUp(user);
  }

  @override
  Future<Either> getAges() async {
    return await sl<AuthFirebaseService>().getAges();
  }

  @override
  Future<Either> signIn(UserSignInRequest user) async {
    return await sl<AuthFirebaseService>().signIn(user);
  }

  @override
  Future<Either> sendPasswordResetEmail(String email) async {
    return await sl<AuthFirebaseService>().sendPasswordResetEmail(email);
  }

  @override
  Future<bool> isLoggedIn() async {
    return await sl<AuthFirebaseService>().isLoggedIn();
  }

  @override
  Future<Either> getUser() async {
    var user = await sl<AuthFirebaseService>().getUser();
    return user.fold((error) {
      return Left(error);
    }, (data) {
      return Right(UserModel.fromMap(data).toEntity());
    });
  }
}
