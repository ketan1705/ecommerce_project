import 'package:ecommerce/core/configs/theme/app_colors.dart';
import 'package:ecommerce/domain/product/entity/product.dart';
import 'package:ecommerce/presentation/product_detail/bloc/favorite_icon_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteButton extends StatelessWidget {
  final ProductEntity productEntity;

  const FavoriteButton({super.key, required this.productEntity});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<FavoriteIconCubit>().onTap(productEntity);
      },
      icon: Container(
        height: 40,
        width: 40,
        decoration: const BoxDecoration(
          color: AppColors.secondBackground,
          shape: BoxShape.circle,
        ),
        child: BlocBuilder<FavoriteIconCubit, bool>(builder: (context, state) {
          return Icon(
            state ? Icons.favorite : Icons.favorite_outline,
            size: 20,
            color: Colors.white,
          );
        }),
      ),
    );
  }
}
