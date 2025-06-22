import 'package:bloc/bloc.dart';
import 'package:ecommerce/domain/product/entity/product.dart';
import 'package:ecommerce/domain/product/use-cases/add_or_remove_fav_products.dart';
import 'package:ecommerce/domain/product/use-cases/is_favorite.dart';

import '../../../service_locator.dart';

class FavoriteIconCubit extends Cubit<bool> {
  FavoriteIconCubit() : super(false);

  void isFavorite(String productId) async {
    var result = await sl<IsFavoriteUseCase>().call(params: productId);
    emit(result);
  }

  void onTap(ProductEntity product) async {
    var result =
        await sl<AddOrRemoveFavProductsUseCase>().call(params: product);

    result.fold((error) {}, (data) {
      emit(data);
    });
  }
}
