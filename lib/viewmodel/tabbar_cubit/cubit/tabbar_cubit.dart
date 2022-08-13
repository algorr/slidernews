import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabbarCubit extends Cubit<int> {
  PageController controller = PageController();
  TabbarCubit() : super(0);
  void updateIndex(int index) =>  emit(index);
}
