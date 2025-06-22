import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/constants/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_creation_request.dart';
import '../models/user_sign_in_request.dart';

abstract class AuthFirebaseService {
  Future<Either> signUp(UserCreationRequest user);

  Future<Either> signIn(UserSignInRequest user);

  Future<Either> getAges();

  Future<Either> sendPasswordResetEmail(String email);

  Future<bool> isLoggedIn();

  Future<Either> getUser();
}

class AuthFirebaseServiceImpl implements AuthFirebaseService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthFirebaseServiceImpl({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  })  : _auth = auth,
        _firestore = firestore;

  @override
  Future<Either> signUp(UserCreationRequest user) async {
    try {
      var data = await _auth.createUserWithEmailAndPassword(
          email: user.email!, password: user.password!);

      _firestore
          .collection(AppConstants.userCollection)
          .doc(data.user!.uid)
          .set({
        'firstName': user.firstName,
        'lastName': user.lastName,
        'email': user.email,
        'gender': user.gender,
        'age': user.age,
        'image': data.user!.photoURL,
        'userId': data.user!.uid
      });

      return const Right('Account Created Successfully');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'email-already-in-use') {
        message = 'Email Already Exists';
      } else if (e.code == 'weak-password') {
        message = 'Password is too weak';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> signIn(UserSignInRequest user) async {
    try {
      var data = await _auth.signInWithEmailAndPassword(
          email: user.email!, password: user.password!);

      if (data.user?.uid != null) {
        return const Right('Account Login Successfully');
      }
      return const Left('Please try again later');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'invalid-email') {
        message = 'User not found for that email';
      } else if (e.code == 'invalid-credential') {
        message = 'Wrong password provided for that user';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> getAges() async {
    try {
      var data = await _firestore.collection(AppConstants.agesCollection).get();
      return Right(data.docs);
    } on Exception {
      return const Left('Please try again later');
    }
  }

  @override
  Future<Either> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return const Right('Password reset email sent');
    } catch (e) {
      return const Left('Something Went Wrong!! Please try again');
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    if (_auth.currentUser != null) {
      return true;
    }
    return false;
  }

  @override
  Future<Either> getUser() async {
    try {
      var currentUser = _auth.currentUser;
      var userData = await _firestore
          .collection(AppConstants.userCollection)
          .doc(currentUser?.uid)
          .get()
          .then((value) => value.data());
      return Right(userData);
    } catch (e) {
      return const Left('Something Went Wrong!! Please try again');
    }
  }
}
