import 'package:ecommerce/common/bloc/products/products_display_cubit.dart';
import 'package:ecommerce/common/widgets/appbar/app_bar.dart';
import 'package:ecommerce/common/widgets/product/products_card.dart';
import 'package:ecommerce/domain/category/entity/category.dart';
import 'package:ecommerce/domain/product/entity/product.dart';
import 'package:ecommerce/domain/product/use-cases/get_products_by_category_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../service_locator.dart';

class CategoryProductsPage extends StatelessWidget {
  final CategoryEntity categoryEntity;

  const CategoryProductsPage({super.key, required this.categoryEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(
        hideBack: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocProvider(
          create: (context) => ProductsDisplayCubit(
              useCase: sl<GetProductsByCategoryIdUseCase>())
            ..displayProducts(params: categoryEntity.categoryId),
          child: BlocBuilder<ProductsDisplayCubit, ProductsDisplayState>(
              builder: (context, state) {
            if (state is ProductsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProductsLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _categoryInfo(state.products),
                  const SizedBox(height: 15),
                  _products(state.products)
                ],
              );
            }
            return Container();
          }),
        ),
      ),
    );
  }

  Widget _categoryInfo(List<ProductEntity> products) {
    return Text(
      '${categoryEntity.title} (${products.length})',
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }

  Widget _products(List<ProductEntity> products) {
    return Expanded(
        child: GridView.builder(
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.6),
            itemBuilder: (context, index) {
              return ProductsCard(productEntity: products[index]);
            }));
  }
}
