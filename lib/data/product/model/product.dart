import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/data/product/model/color.dart';

import '../../../domain/product/entity/product.dart';

class ProductModel {
  final String categoryId;
  final List<ProductColorModel> colors;
  final Timestamp createdDate;
  final num discountedPrice;
  final int gender;
  final List<String> images;
  final num price;
  final List<String> sizes;
  final String productId;
  final int salesNumber;
  final String title;

  ProductModel(
      {required this.categoryId,
      required this.colors,
      required this.createdDate,
      required this.discountedPrice,
      required this.gender,
      required this.images,
      required this.price,
      required this.sizes,
      required this.productId,
      required this.salesNumber,
      required this.title});

  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'colors': colors.map((color) => color.toMap()).toList(),
      'createdDate': createdDate,
      'discountedPrice': discountedPrice,
      'gender': gender,
      'images': images.map((e) => e.toString()).toList(),
      'price': price,
      'sizes': sizes.map((e) => e.toString()).toList(),
      'productId': productId,
      'salesNumber': salesNumber,
      'title': title,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      categoryId: map['categoryId'] as String,
      colors: List<ProductColorModel>.from(
          map['colors'].map((e) => ProductColorModel.fromMap(e))),
      createdDate: map['createdDate'] as Timestamp,
      discountedPrice: map['discountedPrice'] as num,
      gender: map['gender'] as int,
      images: List<String>.from(map['images'].map((e) => e.toString())),
      price: map['price'] as num,
      sizes: List<String>.from(map['sizes'].map((e) => e.toString())),
      productId: map['productId'] as String,
      salesNumber: map['salesNumber'] as int,
      title: map['title'] as String,
    );
  }
}

extension ProductXModel on ProductModel {
  ProductEntity toEntity() {
    return ProductEntity(
        categoryId: categoryId,
        colors: colors.map((e) => e.toEntity()).toList(),
        createdDate: createdDate,
        discountedPrice: discountedPrice,
        gender: gender,
        images: images,
        price: price,
        sizes: sizes,
        productId: productId,
        salesNumber: salesNumber,
        title: title);
  }
}

extension ProductXEntity on ProductEntity {
  ProductModel fromEntity() {
    return ProductModel(
        categoryId: categoryId,
        colors: colors.map((e) => e.fromEntity()).toList(),
        createdDate: createdDate,
        discountedPrice: discountedPrice,
        gender: gender,
        images: images,
        price: price,
        sizes: sizes,
        productId: productId,
        salesNumber: salesNumber,
        title: title);
  }
}
