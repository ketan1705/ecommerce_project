import 'package:ecommerce/common/bloc/category/category_display_cubit.dart';
import 'package:ecommerce/common/helper/navigator/app_navigator.dart';
import 'package:ecommerce/domain/category/entity/category.dart';
import 'package:ecommerce/presentation/all_categories/pages/all_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/helper/images/image_display.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryDisplayCubit()..displayCategories(),
      child: BlocBuilder<CategoryDisplayCubit, CategoryDisplayState>(
          builder: (context, state) {
        if (state is CategoryLoading) {
          return const CircularProgressIndicator();
        }
        if (state is CategoryFailure) {
          return Container(
              alignment: Alignment.center,
              child: const Text("Something went wrong!!"));
        }
        if (state is CategoryLoaded) {
          return Column(
            children: [
              _seaAll(context),
              const SizedBox(height: 20),
              _categories(state.categories),
            ],
          );
        }
        return Container();
      }),
    );
  }

  Widget _seaAll(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Categories',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          GestureDetector(
            onTap: () {
              AppNavigator.push(context, const AllCategoriesPage());
            },
            child: const Text(
              'See All',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _categories(List<CategoryEntity> category) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              ImageDisplayHelper.generateCategoryImageUrl(
                                  category[index].image)))
                      // category[index].image)),
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  category[index].title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 14),
                )
              ],
            );
          },
          separatorBuilder: (context, index) => const SizedBox(width: 15),
          itemCount: category.length),
    );
  }
}
