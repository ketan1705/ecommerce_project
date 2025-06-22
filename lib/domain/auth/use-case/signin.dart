import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/auth/models/user_sign_in_request.dart';

import '../../../core/usecases/use_case.dart';
import '../../../service_locator.dart';
import '../repository/auth_repository.dart';

class SignInUseCase implements UseCase<Either, UserSignInRequest> {
  @override
  Future<Either> call({UserSignInRequest? params}) async {
    return await sl<AuthRepository>().signIn(params!);
  }
}
