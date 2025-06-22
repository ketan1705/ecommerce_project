import 'package:bloc/bloc.dart';
import 'package:ecommerce/core/usecases/use_case.dart';

import '../../../domain/product/entity/product.dart';

part 'products_display_state.dart';

class ProductsDisplayCubit extends Cubit<ProductsDisplayState> {
  final UseCase useCase;

  ProductsDisplayCubit({required this.useCase}) : super(ProductInitialState());

  void displayProducts({dynamic params}) async {
    emit(ProductsLoading());
    var productData = await useCase.call(params: params);
    productData.fold((error) {
      emit(ProductsFailure());
    }, (data) {
      emit(ProductsLoaded(products: data));
    });
  }

  void displayInitial() {
    emit(ProductInitialState());
  }
}
