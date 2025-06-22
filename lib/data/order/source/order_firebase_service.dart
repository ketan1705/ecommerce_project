import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/constants/app_constants.dart';
import 'package:ecommerce/data/order/models/add_to_cart_request.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/order_registration_request.dart';

abstract class OrderFirebaseService {
  Future<Either> addToCart(AddToCartRequest addToCartReq);

  Future<Either> getCartProducts();

  Future<Either> removeCartProducts(String id);

  Future<Either> placeOrder(OrderRegistrationRequest orderReq);

  Future<Either> getOrders();
}

class OrderFirebaseServiceImpl extends OrderFirebaseService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  OrderFirebaseServiceImpl(
      {required FirebaseAuth auth, required FirebaseFirestore firestore})
      : _auth = auth,
        _firestore = firestore;

  @override
  Future<Either> addToCart(AddToCartRequest addToCartReq) async {
    try {
      var user = _auth.currentUser;
      await _firestore
          .collection(AppConstants.userCollection)
          .doc(user!.uid)
          .collection(AppConstants.cartCollection)
          .add(addToCartReq.toMap());
      return const Right('Add to Cart successfully');
    } on Exception {
      return const Left('Please try again!!');
    }
  }

  @override
  Future<Either> getCartProducts() async {
    try {
      var user = _auth.currentUser;

      var data = await _firestore
          .collection(AppConstants.userCollection)
          .doc(user!.uid)
          .collection(AppConstants.cartCollection)
          .get();

      final products = data.docs.map((doc) {
        return {
          ...doc.data(),
          'id': doc.id,
        };
      }).toList();
      return Right(products);
      // return Right(data.docs.map((e) => e.data()).toList());
    } catch (e) {
      return const Left('Please try again!!');
    }
  }

  @override
  Future<Either> removeCartProducts(String id) async {
    try {
      var user = _auth.currentUser;
      await _firestore
          .collection(AppConstants.userCollection)
          .doc(user!.uid)
          .collection(AppConstants.cartCollection)
          .doc(id)
          .delete();
      return const Right('Product deleted successfully!!');
    } catch (e) {
      return const Left('Please try again!!');
    }
  }

  @override
  Future<Either> placeOrder(OrderRegistrationRequest orderReq) async {
    try {
      var user = _auth.currentUser;
      await _firestore
          .collection(AppConstants.userCollection)
          .doc(user!.uid)
          .collection(AppConstants.orderCollection)
          .add(orderReq.toMap());
      for (var item in orderReq.products) {
        await _firestore
            .collection(AppConstants.userCollection)
            .doc(user.uid)
            .collection(AppConstants.cartCollection)
            .doc(item.id)
            .delete();
      }
      return const Right('Order placed successfully!!');
    } catch (e) {
      return const Left('Please try again!!');
    }
  }

  @override
  Future<Either> getOrders() async {
    try {
      var user = _auth.currentUser;
      var data = await _firestore
          .collection(AppConstants.userCollection)
          .doc(user!.uid)
          .collection(AppConstants.orderCollection)
          .get();

      return Right(data.docs.map((e) => e.data()).toList());
    } catch (e) {
      return const Left('Please try again!!');
    }
  }
}
