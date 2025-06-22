import 'package:ecommerce/domain/order/entity/product_ordered.dart';

class CartHelper {
  static double calculateCartSubtotal(List<ProductOrderedEntity> products) {
    double subtotal = 0;
    for (var product in products) {
      subtotal += product.totalPrice;
    }
    return double.parse(subtotal.toStringAsFixed(2));
  }
}
