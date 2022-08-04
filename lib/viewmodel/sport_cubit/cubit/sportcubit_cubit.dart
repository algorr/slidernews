import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slidernews/repository/news_repository.dart';
import '../../../model/articles.dart';

part 'sportcubit_state.dart';

class SportcubitCubit extends Cubit<SportcubitState> {
  final NewsApiRepository _repository;
  SportcubitCubit(this._repository) : super(SportcubitInitial());

  Future<List<Articles>?> fetch() async {
    final articleList = await _repository.fetchSportArticles();
    emit(SportLoadingState());
    if (articleList!.isNotEmpty) {
      print("Article listesi dolu!");
      emit(SportLoadedState(articleList));
    } else {
      emit(SportErrorState());
    }
    return null;
  }

  Future<void> init() async {
    await _repository.fetchSportArticles();
    await fetch();
  }
}
