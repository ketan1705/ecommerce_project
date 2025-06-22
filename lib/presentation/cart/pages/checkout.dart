import 'package:ecommerce/common/bloc/button/button_state.dart';
import 'package:ecommerce/common/bloc/button/button_state_cubit.dart';
import 'package:ecommerce/common/helper/cart/cart_helper.dart';
import 'package:ecommerce/common/widgets/appbar/app_bar.dart';
import 'package:ecommerce/common/widgets/button/basic_reactive_button.dart';
import 'package:ecommerce/data/order/models/order_registration_request.dart';
import 'package:ecommerce/domain/order/entity/product_ordered.dart';
import 'package:ecommerce/domain/order/order_di.dart';
import 'package:ecommerce/presentation/cart/pages/order_placed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/helper/navigator/app_navigator.dart';

class CheckoutPage extends StatelessWidget {
  final List<ProductOrderedEntity> products;

  CheckoutPage({super.key, required this.products});

  final TextEditingController _addressCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(
        title: Text('Checkout'),
      ),
      body: BlocProvider(
        create: (context) => ButtonStateCubit(),
        child: BlocListener<ButtonStateCubit, ButtonState>(
          listener: (context, state) {
            if (state is ButtonSuccessState) {
              AppNavigator.pushAndRemoveUntil(context, const OrderPlacedPage());
            }
            if (state is ButtonFailureState) {
              var snackBar = SnackBar(
                content: Text(state.errorMessage),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Builder(
              builder: (context) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _addressField(context),
                    BasicReactiveButton(
                      onPressed: () {
                        context.read<ButtonStateCubit>().execute(
                            useCase: PlaceOrderUseCase(),
                            params: OrderRegistrationRequest(
                                products: products,
                                createdDate: DateTime.now().toString(),
                                shippingAddress: _addressCon.text,
                                itemCount: products.length,
                                totalPrice: CartHelper.calculateCartSubtotal(
                                    products)));
                      },
                      content: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${CartHelper.calculateCartSubtotal(products).toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'Place Order',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _addressField(BuildContext context) {
    return TextField(
      controller: _addressCon,
      minLines: 2,
      maxLines: 4,
      decoration: const InputDecoration(hintText: 'Shipping Address'),
    );
  }
}
