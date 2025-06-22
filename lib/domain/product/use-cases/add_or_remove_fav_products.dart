import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/usecases/use_case.dart';
import 'package:ecommerce/domain/product/entity/product.dart';
import 'package:ecommerce/domain/product/repository/product_repository.dart';

import '../../../service_locator.dart';

class AddOrRemoveFavProductsUseCase implements UseCase<Either, ProductEntity> {
  @override
  Future<Either> call({ProductEntity? params}) async {
    return await sl<ProductRepository>().addOrRemoveFavoriteProduct(params!);
  }
}
