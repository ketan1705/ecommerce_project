import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/usecases/use_case.dart';
import 'package:ecommerce/domain/category/repository/category_repository.dart';

import '../../../service_locator.dart';

class GetCategoryUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<CategoryRepository>().getCategories();
  }
}
