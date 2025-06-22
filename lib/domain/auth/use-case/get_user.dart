import 'package:dartz/dartz.dart';

import '../../../core/usecases/use_case.dart';
import '../../../service_locator.dart';
import '../repository/auth_repository.dart';

class GetUserUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<AuthRepository>().getUser();
  }
}
