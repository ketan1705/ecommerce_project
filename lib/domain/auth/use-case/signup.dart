import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/usecases/use_case.dart';
import 'package:ecommerce/data/auth/models/user_creation_request.dart';
import 'package:ecommerce/domain/auth/repository/auth_repository.dart';

import '../../../service_locator.dart';

class SignUpUseCase implements UseCase<Either, UserCreationRequest> {
  @override
  Future<Either> call({UserCreationRequest? params}) async {
    return await sl<AuthRepository>().signUp(params!);
  }
}
