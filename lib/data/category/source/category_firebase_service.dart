import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/constants/app_constants.dart';

abstract class CategoryFirebaseService {
  Future<Either> getCategories();
}

class CategoryFirebaseServiceImpl extends CategoryFirebaseService {
  final FirebaseFirestore _firestore;

  CategoryFirebaseServiceImpl({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  @override
  Future<Either> getCategories() async {
    try {
      var categories =
          await _firestore.collection(AppConstants.categoryCollection).get();
      return Right(categories.docs.map((e) => e.data()).toList());
    } on Exception {
      return const Left('Something Went Wrong!! Please try again');
    }
  }
}
