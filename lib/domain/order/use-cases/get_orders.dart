import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/usecases/use_case.dart';
import 'package:ecommerce/domain/order/repository/order_repository.dart';

import '../../../service_locator.dart';

class GetOrdersUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<OrderRepository>().getOrders();
  }
}
