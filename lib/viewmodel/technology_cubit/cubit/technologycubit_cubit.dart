import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slidernews/model/articles.dart';
import 'package:slidernews/repository/news_repository.dart';

part 'technologycubit_state.dart';

class TechnologycubitCubit extends Cubit<TechnologycubitState> {
  final NewsApiRepository _repository;
  TechnologycubitCubit(this._repository) : super(TechnologycubitInitial());

  Future<List<Articles>?> fetch() async {
    final articleList = await _repository.fetchTechnologyArticles();
    emit(TechnologyLoadingState());
    if (articleList!.isNotEmpty) {
      print("Article listesi dolu!");
      emit(TechnologyLoadedState(articleList));
    } else {
      emit(TechnologyErrorState());
    }
    return null;
  }


  Future<void> init() async {
    await _repository.fetchTechnologyArticles();
    await fetch();
  }
}
