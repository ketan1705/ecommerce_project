import 'package:ecommerce/data/order/models/product_ordered.dart';
import 'package:ecommerce/domain/order/entity/product_ordered.dart';

class OrderRegistrationRequest {
  final List<ProductOrderedEntity> products;
  final String createdDate;
  final String shippingAddress;
  final int itemCount;
  final double totalPrice;

  OrderRegistrationRequest(
      {required this.products,
      required this.createdDate,
      required this.shippingAddress,
      required this.itemCount,
      required this.totalPrice});

  Map<String, dynamic> toMap() {
    return {
      'products': products.map((e) => e.fromEntity().toMap()).toList(),
      'createdDate': createdDate,
      'shippingAddress': shippingAddress,
      'itemCount': itemCount,
      'totalPrice': totalPrice,
    };
  }
}
