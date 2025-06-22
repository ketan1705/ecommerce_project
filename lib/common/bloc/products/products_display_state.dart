part of 'products_display_cubit.dart';

abstract class ProductsDisplayState {}

class ProductInitialState extends ProductsDisplayState {}

class ProductsLoading extends ProductsDisplayState {}

class ProductsLoaded extends ProductsDisplayState {
  final List<ProductEntity> products;

  ProductsLoaded({required this.products});
}

class ProductsFailure extends ProductsDisplayState {}
