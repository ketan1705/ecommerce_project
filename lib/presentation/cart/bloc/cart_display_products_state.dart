part of 'cart_display_products_cubit.dart';

abstract class CartDisplayProductsState {}

final class CartProductLoading extends CartDisplayProductsState {}

final class CartProductLoaded extends CartDisplayProductsState {
  final List<ProductOrderedEntity> cartProducts;

  CartProductLoaded({required this.cartProducts});
}

final class CartProductFailure extends CartDisplayProductsState {
  final String errorMessage;

  CartProductFailure({required this.errorMessage});
}
