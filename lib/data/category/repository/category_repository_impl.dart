import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/category/models/category.dart';
import 'package:ecommerce/data/category/source/category_firebase_service.dart';
import 'package:ecommerce/domain/category/repository/category_repository.dart';
import 'package:flutter/foundation.dart';

import '../../../service_locator.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  @override
  Future<Either> getCategories() async {
    var categories = await sl<CategoryFirebaseService>().getCategories();
    return categories.fold((error) {
      return Left(error);
    }, (data) {
      if (kDebugMode) {
        print('Category Data: $data');
      }
      return Right(List.from(data)
          .map((e) => CategoryModel.fromMap(e).toEntity())
          .toList());
    });
  }
}
