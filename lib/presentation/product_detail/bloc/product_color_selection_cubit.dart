import 'package:bloc/bloc.dart';

class ProductColorSelectionCubit extends Cubit<int> {
  ProductColorSelectionCubit() : super(0);
  int selectedIndex = 0;

  void itemSelection(int index) {
    selectedIndex = index;
    emit(index);
  }
}
