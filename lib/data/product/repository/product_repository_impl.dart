import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/product/model/product.dart';
import 'package:ecommerce/data/product/source/product_firebase_service.dart';
import 'package:ecommerce/domain/product/entity/product.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/product/repository/product_repository.dart';
import '../../../service_locator.dart';

class ProductRepositoryImpl extends ProductRepository {
  @override
  Future<Either> getTopSelling() async {
    var topProducts = await sl<ProductFirebaseService>().getTopSelling();
    return topProducts.fold((error) {
      return Left(error);
    }, (data) {
      if (kDebugMode) {
        print('Top Products Data: $data');
      }
      return Right(List.from(data)
          .map((e) => ProductModel.fromMap(e).toEntity())
          .toList());
    });
  }

  @override
  Future<Either> getNewIn() async {
    var newProducts = await sl<ProductFirebaseService>().getNewIn();
    return newProducts.fold((error) {
      return Left(error);
    }, (data) {
      if (kDebugMode) {
        print('New in Products Data: $data');
      }
      return Right(List.from(data)
          .map((e) => ProductModel.fromMap(e).toEntity())
          .toList());
    });
  }

  @override
  Future<Either> getProductsByCategoryId(String categoryId) async {
    var products =
        await sl<ProductFirebaseService>().getProductsByCategoryId(categoryId);
    return products.fold((error) {
      return Left(error);
    }, (data) {
      if (kDebugMode) {
        print('Products by category Id : $data');
      }
      return Right(List.from(data)
          .map((e) => ProductModel.fromMap(e).toEntity())
          .toList());
    });
  }

  @override
  Future<Either> getProductsByTitle(String title) async {
    if (kDebugMode) {
      print('Title in Product Repository : $title');
    }
    var products = await sl<ProductFirebaseService>().getProductsByTitle(title);
    return products.fold((error) {
      return Left(error);
    }, (data) {
      if (kDebugMode) {
        print('Products by Title : $data');
      }
      return Right(List.from(data)
          .map((e) => ProductModel.fromMap(e).toEntity())
          .toList());
    });
  }

  @override
  Future<Either> addOrRemoveFavoriteProduct(ProductEntity product) async {
    var products =
        await sl<ProductFirebaseService>().addOrRemoveFavoriteProduct(product);
    return products.fold((error) {
      return Left(error);
    }, (data) {
      return Right(data);
    });
  }

  @override
  Future<bool> isFavorite(String productId) async {
    return await sl<ProductFirebaseService>().isFavorite(productId);
  }

  @override
  Future<Either> getFavoriteProducts() async {
    var products = await sl<ProductFirebaseService>().getFavoriteProducts();
    return products.fold((error) {
      return Left(error);
    }, (data) {
      return Right(List.from(data)
          .map((e) => ProductModel.fromMap(e).toEntity())
          .toList());
    });
  }
}
