import 'package:cloud_firestore/cloud_firestore.dart';

class OrderStatusEntity {
  final String title;
  final bool isDone;
  final Timestamp createdDate;

  OrderStatusEntity(
      {required this.title, required this.isDone, required this.createdDate});
}
