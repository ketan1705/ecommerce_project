import 'package:bloc/bloc.dart';
import 'package:ecommerce/domain/order/entity/order.dart';
import 'package:ecommerce/domain/order/order_di.dart';

import '../../../service_locator.dart';

part 'orders_display_state.dart';

class OrderDisplayCubit extends Cubit<OrdersDisplayState> {
  OrderDisplayCubit() : super(OrdersLoadingState());

  void displayOrders() async {
    var data = await sl<GetOrdersUseCase>().call();
    return data.fold((error) {
      emit(OrdersFailureState(errMessage: error));
    }, (orders) {
      emit(OrdersLoadedState(orders: orders));
    });
  }
}
