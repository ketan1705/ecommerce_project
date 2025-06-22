import 'package:bloc/bloc.dart';
import 'package:ecommerce/domain/category/entity/category.dart';
import 'package:ecommerce/domain/category/use-cases/get_category.dart';

import '../../../service_locator.dart';

part 'category_display_state.dart';

class CategoryDisplayCubit extends Cubit<CategoryDisplayState> {
  CategoryDisplayCubit() : super(CategoryLoading());

  void displayCategories() async {
    var categories = await sl<GetCategoryUseCase>().call();
    categories.fold((error) {
      emit(CategoryFailure());
    }, (data) {
      emit(CategoryLoaded(categories: data));
    });
  }
}
