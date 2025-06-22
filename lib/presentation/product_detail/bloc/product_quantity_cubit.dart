import 'package:bloc/bloc.dart';

class ProductQuantityCubit extends Cubit<int> {
  ProductQuantityCubit() : super(1);

  void incrementQuantity() {
    emit(state + 1);
  }

  void decrementQuantity() {
    if (state != 1) {
      emit(state - 1);
    }
  }
}
