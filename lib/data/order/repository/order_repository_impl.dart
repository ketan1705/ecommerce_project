import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/order/models/add_to_cart_request.dart';
import 'package:ecommerce/data/order/models/order.dart';
import 'package:ecommerce/data/order/models/order_registration_request.dart';
import 'package:ecommerce/data/order/source/order_firebase_service.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/order/repository/order_repository.dart';
import '../../../service_locator.dart';
import '../models/product_ordered.dart';

class OrderRepositoryImpl extends OrderRepository {
  @override
  Future<Either> addToCart(AddToCartRequest addToCartReq) async {
    return await sl<OrderFirebaseService>().addToCart(addToCartReq);
  }

  @override
  Future<Either> getCartProducts() async {
    var products = await sl<OrderFirebaseService>().getCartProducts();
    return products.fold((error) {
      return Left(error);
    }, (data) {
      if (kDebugMode) {
        print('cart Products : $data');
      }
      return Right(List.from(data)
          .map((e) => ProductOrderedModel.fromMap(e).toEntity())
          .toList());
    });
  }

  @override
  Future<Either> removeCartProducts(String id) async {
    var data = await sl<OrderFirebaseService>().removeCartProducts(id);
    return data.fold((error) {
      return Left(error);
    }, (message) {
      return Right(message);
    });
  }

  @override
  Future<Either> placeOrder(OrderRegistrationRequest orderReq) async {
    var data = await sl<OrderFirebaseService>().placeOrder(orderReq);
    return data.fold((error) {
      return Left(error);
    }, (message) {
      return Right(message);
    });
  }

  @override
  Future<Either> getOrders() async {
    var data = await sl<OrderFirebaseService>().getOrders();
    return data.fold((error) {
      return Left(error);
    }, (data) {
      return Right(List.from(data)
          .map((e) => OrderModel.fromMap(e).toEntity())
          .toList());
    });
  }
}
