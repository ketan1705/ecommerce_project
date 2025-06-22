part of 'orders_display_cubit.dart';

abstract class OrdersDisplayState {}

final class OrdersLoadingState extends OrdersDisplayState {}

final class OrdersLoadedState extends OrdersDisplayState {
  final List<OrderEntity> orders;

  OrdersLoadedState({required this.orders});
}

final class OrdersFailureState extends OrdersDisplayState {
  final String errMessage;

  OrdersFailureState({required this.errMessage});
}
