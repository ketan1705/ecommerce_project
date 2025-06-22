import 'package:ecommerce/common/widgets/appbar/app_bar.dart';
import 'package:ecommerce/domain/order/entity/order.dart';
import 'package:ecommerce/presentation/settings/bloc/orders_display_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/configs/theme/app_colors.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(
        title: Text('My Orders'),
      ),
      body: BlocProvider(
        create: (context) => OrderDisplayCubit()..displayOrders(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<OrderDisplayCubit, OrdersDisplayState>(
            builder: (context, state) {
              if (state is OrdersLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is OrdersFailureState) {
                return Center(child: Text(state.errMessage));
              }
              if (state is OrdersLoadedState) {
                return _orders(state.orders);
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget _orders(List<OrderEntity> orders) {
    return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.secondBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.receipt_rounded),
                    const SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Orders: #${orders[index].code}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '${orders[index].products.length} items',
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Icon(Icons.arrow_forward_ios_rounded)
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
              height: 20,
            ),
        itemCount: 2);
  }
}
