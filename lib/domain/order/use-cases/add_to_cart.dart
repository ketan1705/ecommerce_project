import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/usecases/use_case.dart';
import 'package:ecommerce/data/order/models/add_to_cart_request.dart';
import 'package:ecommerce/domain/order/repository/order_repository.dart';

import '../../../service_locator.dart';

class AddToCartUseCase implements UseCase<Either, AddToCartRequest> {
  @override
  Future<Either> call({AddToCartRequest? params}) async {
    return await sl<OrderRepository>().addToCart(params!);
  }
}
