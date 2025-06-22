import 'package:ecommerce/common/bloc/products/products_display_cubit.dart';
import 'package:ecommerce/common/widgets/appbar/app_bar.dart';
import 'package:ecommerce/domain/product/use-cases/get_favorite_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widgets/product/products_card.dart';
import '../../../domain/product/entity/product.dart';
import '../../../service_locator.dart';

class MyFavoritesPage extends StatelessWidget {
  const MyFavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(
        title: Text('My Favorites'),
      ),
      body: BlocProvider(
        create: (context) =>
            ProductsDisplayCubit(useCase: sl<GetFavoriteProductsUseCase>())
              ..displayProducts(),
        child: BlocBuilder<ProductsDisplayCubit, ProductsDisplayState>(
            builder: (context, state) {
          if (state is ProductsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProductsFailure) {
            return const Center(
              child: Text('Please try again'),
            );
          }
          if (state is ProductsLoaded) {
            return _products(state.products);
          }

          return Container();
        }),
      ),
    );
  }

  Widget _products(List<ProductEntity> products) {
    return Expanded(
      child: GridView.builder(
        itemCount: products.length,
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.6),
        itemBuilder: (context, index) {
          return ProductsCard(productEntity: products[index]);
        },
      ),
    );
  }
}
