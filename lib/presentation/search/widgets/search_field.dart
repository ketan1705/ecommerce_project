import 'package:ecommerce/common/bloc/products/products_display_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/configs/assets/app_vectors.dart';

class SearchField extends StatelessWidget {
  SearchField({super.key});

  final TextEditingController _searchCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: _searchCon,
        onChanged: (value) {
          if (value.isEmpty) {
            context.read<ProductsDisplayCubit>().displayInitial();
          } else {
            context.read<ProductsDisplayCubit>().displayProducts(params: value);
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(12),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            prefixIcon: SvgPicture.asset(
              AppVectors.search,
              fit: BoxFit.none,
            ),
            hintText: 'Search'),
      ),
    );
  }
}
