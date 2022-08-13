import 'package:flutter_bloc/flutter_bloc.dart';

class TabbarNewsCubit extends Cubit<int> {
  TabbarNewsCubit() : super(0);

  void updateIndex(int index) => emit(index);
}
