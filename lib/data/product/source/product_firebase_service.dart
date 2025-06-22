import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/constants/app_constants.dart';
import 'package:ecommerce/data/product/model/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/product/entity/product.dart';

abstract class ProductFirebaseService {
  Future<Either> getTopSelling();

  Future<Either> getNewIn();

  Future<Either> getProductsByCategoryId(String categoryId);

  Future<Either> getProductsByTitle(String title);

  Future<Either> addOrRemoveFavoriteProduct(ProductEntity product);

  Future<bool> isFavorite(String productId);

  Future<Either> getFavoriteProducts();
}

class ProductFirebaseServiceImpl extends ProductFirebaseService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  ProductFirebaseServiceImpl(
      {required FirebaseAuth auth, required FirebaseFirestore firestore})
      : _auth = auth,
        _firestore = firestore;

  @override
  Future<Either> getTopSelling() async {
    try {
      var data = await _firestore
          .collection(AppConstants.productsCollection)
          .where('salesNumber', isGreaterThanOrEqualTo: 30)
          .get();
      return Right(data.docs.map((e) => e.data()).toList());
    } catch (e) {
      return const Left('Please try again!!');
    }
  }

  @override
  Future<Either> getNewIn() async {
    try {
      var data = await _firestore
          .collection(AppConstants.productsCollection)
          .where('createdDate',
              isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime(2025, 5, 17)))
          .get();
      return Right(data.docs.map((e) => e.data()).toList());
    } catch (e) {
      return const Left('Please try again!!');
    }
  }

  @override
  Future<Either> getProductsByCategoryId(String categoryId) async {
    try {
      var data = await _firestore
          .collection(AppConstants.productsCollection)
          .where('categoryId', isEqualTo: categoryId)
          .get();
      return Right(data.docs.map((e) => e.data()).toList());
    } catch (e) {
      return const Left('Please try again!!');
    }
  }

  @override
  Future<Either> getProductsByTitle(String title) async {
    try {
      if (kDebugMode) {
        print('Title in Product Service : $title');
      }
      var data = await _firestore
          .collection(AppConstants.productsCollection)
          .where('title', isGreaterThanOrEqualTo: title)
          .get();
      return Right(data.docs.map((e) => e.data()).toList());
    } catch (e) {
      return const Left('Please try again!!');
    }
  }

  @override
  Future<Either> addOrRemoveFavoriteProduct(ProductEntity product) async {
    try {
      var user = _auth.currentUser;
      var products = await _firestore
          .collection(AppConstants.userCollection)
          .doc(user!.uid)
          .collection(AppConstants.favoriteCollection)
          .where('productId', isEqualTo: product.productId)
          .get();

      if (products.docs.isNotEmpty) {
        await products.docs.first.reference.delete();
        return const Right(false);
      } else {
        await _firestore
            .collection(AppConstants.userCollection)
            .doc(user.uid)
            .collection(AppConstants.favoriteCollection)
            .add(product.fromEntity().toMap());
        return const Right(true);
      }
    } catch (e) {
      return const Left('Please try again!!');
    }
  }

  @override
  Future<bool> isFavorite(String productId) async {
    try {
      var user = _auth.currentUser;
      var favProduct = await _firestore
          .collection(AppConstants.userCollection)
          .doc(user!.uid)
          .collection(AppConstants.favoriteCollection)
          .get();

      return favProduct.docs.isNotEmpty ? true : false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either> getFavoriteProducts() async {
    try {
      var user = _auth.currentUser;
      var data = await _firestore
          .collection(AppConstants.userCollection)
          .doc(user!.uid)
          .collection(AppConstants.favoriteCollection)
          .get();
      return Right(data.docs.map((e) => e.data()).toList());
    } catch (e) {
      return const Left('Please try again!!');
    }
  }

/*  @override
  Future<void> addProducts() async {
    final List<ProductModel> generatedProducts = [
      ProductModel(
        productId: '',
        title: 'Smartwatch Series X',
        categoryId: 'iDpAsVSrDHcu5ixPSGpq',
        createdDate: Timestamp.now(),
        discountedPrice: 199.99,
        gender: 1,
        images: ["Smartwatch1.jpg"],
        price: 249.99,
        salesNumber: 42,
        sizes: ['One Size'],
        colors: [
          ProductColorModel(title: 'Black', rgb: [0, 0, 0]),
          ProductColorModel(title: 'Silver', rgb: [192, 192, 192]),
          ProductColorModel(title: 'Rose Gold', rgb: [183, 110, 121]),
        ],
      ),
      ProductModel(
        productId: '',
        title: 'Waterproof Shoulder Bag',
        categoryId: 'czSDV3bY92HuyISej250',
        createdDate: Timestamp.now(),
        discountedPrice: 39.99,
        gender: 0,
        images: ["Shoulder-Bag.jpg"],
        price: 49.99,
        salesNumber: 28,
        sizes: ['Standard'],
        colors: [
          ProductColorModel(title: 'Navy Blue', rgb: [0, 0, 128]),
          ProductColorModel(title: 'Beige', rgb: [245, 245, 220]),
          ProductColorModel(title: 'Olive', rgb: [128, 128, 0]),
        ],
      ),
      ProductModel(
        productId: '',
        title: 'Wireless Earbuds Pro',
        categoryId: 'dECrbcnEgs1hU9UuW1Mz',
        createdDate: Timestamp.now(),
        discountedPrice: 89.99,
        gender: 1,
        images: ["Wireless-Earbuds.jpg"],
        price: 119.99,
        salesNumber: 51,
        sizes: ['One Size'],
        colors: [
          ProductColorModel(title: 'White', rgb: [255, 255, 255]),
          ProductColorModel(title: 'Matte Black', rgb: [47, 79, 79]),
          ProductColorModel(title: 'Graphite', rgb: [105, 105, 105]),
        ],
      ),
      ProductModel(
        productId: '',
        title: 'Men’s Slip-On Sneakers',
        categoryId: 'Q1cqMkxBsa84KA5ACK0y',
        createdDate: Timestamp.now(),
        discountedPrice: 54.99,
        gender: 1,
        images: ["Sneakers1.jpg"],
        price: 64.99,
        salesNumber: 17,
        sizes: ['8', '9', '10', '11'],
        colors: [
          ProductColorModel(title: 'Black', rgb: [0, 0, 0]),
          ProductColorModel(title: 'White', rgb: [255, 255, 255]),
          ProductColorModel(title: 'Brown', rgb: [165, 42, 42]),
        ],
      ),
      ProductModel(
        productId: '',
        title: 'Oversized Hoodie for Women',
        categoryId: 'GBmDhUlLAC6vGpCwAVUb',
        createdDate: Timestamp.now(),
        discountedPrice: 44.99,
        gender: 0,
        images: ["Hoodie.jpg"],
        price: 59.99,
        salesNumber: 33,
        sizes: ['S', 'M', 'L'],
        colors: [
          ProductColorModel(title: 'Pink', rgb: [255, 192, 203]),
          ProductColorModel(title: 'Lavender', rgb: [230, 230, 250]),
          ProductColorModel(title: 'Cream', rgb: [255, 253, 208]),
        ],
      ),
      ProductModel(
        productId: '',
        title: 'Cotton Graphic Shorts',
        categoryId: 'pGlaT7SiVTwU2lN2c8pP',
        createdDate: Timestamp.now(),
        discountedPrice: 24.99,
        gender: 1,
        images: ["Graphic-shorts.jpg"],
        price: 34.99,
        salesNumber: 12,
        sizes: ['M', 'L', 'XL'],
        colors: [
          ProductColorModel(title: 'Grey', rgb: [128, 128, 128]),
          ProductColorModel(title: 'Red', rgb: [255, 0, 0]),
          ProductColorModel(title: 'Navy', rgb: [0, 0, 128]),
        ],
      ),
      ProductModel(
        productId: '',
        title: 'USB-C Charging Hub',
        categoryId: 'iDpAsVSrDHcu5ixPSGpq',
        createdDate: Timestamp.now(),
        discountedPrice: 29.99,
        gender: 1,
        images: ["Usb-hub.jpg"],
        price: 39.99,
        salesNumber: 36,
        sizes: ['Universal'],
        colors: [
          ProductColorModel(title: 'Silver', rgb: [192, 192, 192]),
          ProductColorModel(title: 'Black', rgb: [0, 0, 0]),
          ProductColorModel(title: 'White', rgb: [255, 255, 255]),
        ],
      ),
      ProductModel(
        productId: '',
        title: 'Canvas Tote Bag',
        categoryId: 'czSDV3bY92HuyISej250',
        createdDate: Timestamp.now(),
        discountedPrice: 14.99,
        gender: 0,
        images: ["Canvas-bag.jpg"],
        price: 19.99,
        salesNumber: 20,
        sizes: ['Standard'],
        colors: [
          ProductColorModel(title: 'Natural', rgb: [250, 240, 230]),
          ProductColorModel(title: 'Black', rgb: [0, 0, 0]),
          ProductColorModel(title: 'Green', rgb: [34, 139, 34]),
        ],
      ),
      ProductModel(
        productId: '',
        title: 'Minimalist Wristwatch',
        categoryId: 'dECrbcnEgs1hU9UuW1Mz',
        createdDate: Timestamp.now(),
        discountedPrice: 74.99,
        gender: 1,
        images: ["Wristwatch.jpg"],
        price: 99.99,
        salesNumber: 63,
        sizes: ['One Size'],
        colors: [
          ProductColorModel(title: 'Gold', rgb: [255, 215, 0]),
          ProductColorModel(title: 'Black', rgb: [0, 0, 0]),
          ProductColorModel(title: 'Brown', rgb: [139, 69, 19]),
        ],
      ),
      ProductModel(
        productId: '',
        title: 'Bluetooth Headphones',
        categoryId: '8zlmsCoz8fut7ixMWliu',
        createdDate: Timestamp.now(),
        discountedPrice: 69.99,
        gender: 1,
        images: ["Headphones.jpg"],
        price: 89.99,
        salesNumber: 26,
        sizes: ['One Size'],
        colors: [
          ProductColorModel(title: 'Black', rgb: [0, 0, 0]),
          ProductColorModel(title: 'Red', rgb: [255, 0, 0]),
          ProductColorModel(title: 'White', rgb: [255, 255, 255]),
        ],
      ),
    ];

    final firestore = FirebaseFirestore.instance;

    for (var product in generatedProducts) {
      final docRef = firestore
          .collection(AppConstants.productsCollection)
          .doc(); // create ID

      final productWithId = ProductModel(
        productId: docRef.id,
        title: product.title,
        categoryId: product.categoryId,
        createdDate: product.createdDate,
        discountedPrice: product.discountedPrice,
        gender: product.gender,
        images: product.images,
        price: product.price,
        salesNumber: product.salesNumber,
        sizes: product.sizes,
        colors: product.colors,
      );

      await docRef.set(productWithId.toMap());
    }
  }*/
}
