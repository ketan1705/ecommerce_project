import 'package:dartz/dartz.dart';
import 'package:ecommerce/service_locator.dart';

import '../../../core/usecases/use_case.dart';
import '../repository/auth_repository.dart';

class GetAgesUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({dynamic params}) async {
    return await sl<AuthRepository>().getAges();
  }
}
