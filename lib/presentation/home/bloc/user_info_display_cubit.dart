import 'package:bloc/bloc.dart';
import 'package:ecommerce/domain/auth/auth_di.dart';
import 'package:ecommerce/presentation/home/bloc/user_info_display_state.dart';

import '../../../service_locator.dart';

class UserInfoDisplayCubit extends Cubit<UserInfoDisplayState> {
  UserInfoDisplayCubit() : super(UserInfoLoading());

  void displayUserInfo() async {
    var userData = await sl<GetUserUseCase>().call();
    userData.fold((error) {
      emit(UserInfoFailure());
    }, (data) {
      emit(UserInfoLoaded(user: data));
    });
  }
}
