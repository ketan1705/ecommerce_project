import 'package:dartz/dartz.dart';

import '../../../core/usecases/use_case.dart';
import '../../../service_locator.dart';
import '../repository/product_repository.dart';

class GetProductsByTitleUseCase implements UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<ProductRepository>().getProductsByTitle(params!);
  }
}
