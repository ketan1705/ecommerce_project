import 'package:dartz/dartz.dart';

import '../../../core/usecases/use_case.dart';
import '../../../service_locator.dart';
import '../repository/auth_repository.dart';

class SendPasswordResetEmailUseCase implements UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<AuthRepository>().sendPasswordResetEmail(params!);
  }
}
