import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/order/models/order_registration_request.dart';

import '../../../core/usecases/use_case.dart';
import '../../../service_locator.dart';
import '../repository/order_repository.dart';

class PlaceOrderUseCase implements UseCase<Either, OrderRegistrationRequest> {
  @override
  Future<Either> call({OrderRegistrationRequest? params}) async {
    return await sl<OrderRepository>().placeOrder(params!);
  }
}
