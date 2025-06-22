import 'package:dartz/dartz.dart';

import '../../../core/usecases/use_case.dart';
import '../../../service_locator.dart';
import '../repository/product_repository.dart';

class GetFavoriteProductsUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<ProductRepository>().getFavoriteProducts();
  }
}
