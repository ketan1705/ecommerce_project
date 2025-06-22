import 'package:ecommerce/core/usecases/use_case.dart';
import 'package:ecommerce/domain/product/repository/product_repository.dart';

import '../../../service_locator.dart';

class IsFavoriteUseCase implements UseCase<bool, String> {
  @override
  Future<bool> call({String? params}) async {
    return await sl<ProductRepository>().isFavorite(params!);
  }
}
