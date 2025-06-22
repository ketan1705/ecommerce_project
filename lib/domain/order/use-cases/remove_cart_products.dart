import 'package:dartz/dartz.dart';

import '../../../core/usecases/use_case.dart';
import '../../../service_locator.dart';
import '../repository/order_repository.dart';

class RemoveCartProductsUseCase implements UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<OrderRepository>().removeCartProducts(params!);
  }
}
