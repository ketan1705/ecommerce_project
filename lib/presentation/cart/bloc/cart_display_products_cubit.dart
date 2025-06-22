import 'package:bloc/bloc.dart';
import 'package:ecommerce/domain/order/entity/product_ordered.dart';
import 'package:ecommerce/domain/order/order_di.dart';

import '../../../service_locator.dart';

part 'cart_display_products_state.dart';

class CartDisplayProductsCubit extends Cubit<CartDisplayProductsState> {
  CartDisplayProductsCubit() : super(CartProductLoading());

  void displayCartProducts() async {
    var cartProducts = await sl<GetCartProductsUseCase>().call();
    cartProducts.fold((error) {
      emit(CartProductFailure(errorMessage: error));
    }, (data) {
      emit(CartProductLoaded(cartProducts: data));
    });
  }

  void removeCartProducts(ProductOrderedEntity product) async {
    var cartProducts =
        await sl<RemoveCartProductsUseCase>().call(params: product.id);
    cartProducts.fold((error) {
      emit(CartProductFailure(errorMessage: error));
    }, (data) {
      // emit(CartProductLoaded(cartProducts: data));
      displayCartProducts();
    });
  }
}
