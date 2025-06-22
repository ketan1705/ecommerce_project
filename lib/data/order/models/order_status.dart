import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/domain/order/entity/order_status.dart';

class OrderStatusModel {
  final String title;
  final bool isDone;
  final Timestamp createdDate;

  OrderStatusModel(
      {required this.title, required this.isDone, required this.createdDate});

  factory OrderStatusModel.fromMap(Map<String, dynamic> map) {
    return OrderStatusModel(
      title: map['title'] as String,
      isDone: map['isDone'] as bool,
      createdDate: map['createdDate'] as Timestamp,
    );
  }
}

extension OrderStatusXModel on OrderStatusModel {
  OrderStatusEntity toEntity() {
    return OrderStatusEntity(
        title: title, isDone: isDone, createdDate: createdDate);
  }
}
