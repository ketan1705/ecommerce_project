import 'package:ecommerce/common/widgets/appbar/app_bar.dart';
import 'package:ecommerce/core/configs/assets/app_vectors.dart';
import 'package:ecommerce/domain/order/entity/product_ordered.dart';
import 'package:ecommerce/presentation/cart/bloc/cart_display_products_cubit.dart';
import 'package:ecommerce/presentation/cart/widgets/product_ordered_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/checkout.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(
        title: Text('Cart'),
      ),
      body: BlocProvider(
        create: (context) => CartDisplayProductsCubit()..displayCartProducts(),
        child: BlocBuilder<CartDisplayProductsCubit, CartDisplayProductsState>(
          builder: (context, state) {
            if (state is CartProductLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is CartProductLoaded) {
              return state.cartProducts.isEmpty
                  ? Center(child: _cartIsEmpty())
                  : Stack(
                      children: [
                        _products(state.cartProducts),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Checkout(products: state.cartProducts),
                        )
                      ],
                    );
            }
            if (state is CartProductFailure) {
              return Center(child: Text(state.errorMessage));
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _products(List<ProductOrderedEntity> products) {
    return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return ProductOrderedCard(productOrderedEntity: products[index]);
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: products.length);
  }

  Widget _cartIsEmpty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(AppVectors.cartBag),
        const SizedBox(height: 20),
        const Text(
          'Cart is empty',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        )
      ],
    );
  }
}
