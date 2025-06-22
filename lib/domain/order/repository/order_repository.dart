import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/order/models/add_to_cart_request.dart';
import 'package:ecommerce/data/order/models/order_registration_request.dart';

abstract class OrderRepository {
  Future<Either> addToCart(AddToCartRequest addToCartReq);

  Future<Either> getCartProducts();

  Future<Either> removeCartProducts(String id);

  Future<Either> placeOrder(OrderRegistrationRequest orderReq);

  Future<Either> getOrders();
}
