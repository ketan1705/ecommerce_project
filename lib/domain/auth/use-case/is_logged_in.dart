import '../../../core/usecases/use_case.dart';
import '../../../service_locator.dart';
import '../repository/auth_repository.dart';

class IsLoggedInUseCase implements UseCase<bool, dynamic> {
  @override
  Future<bool> call({params}) async {
    return await sl<AuthRepository>().isLoggedIn();
  }
}
