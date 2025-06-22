import 'package:bloc/bloc.dart';
import 'package:ecommerce/domain/auth/auth_di.dart';

import '../../../service_locator.dart';
import 'ages_display_state.dart';

class AgesDisplayCubit extends Cubit<AgesDisplayState> {
  AgesDisplayCubit() : super(AgesLoading());

  void displayAges() async {
    var data = await sl<GetAgesUseCase>().call();

    data.fold((message) {
      emit(AgesLoadFailure(message: message));
    }, (data) {
      emit(AgesLoaded(ages: data));
    });
  }
}
