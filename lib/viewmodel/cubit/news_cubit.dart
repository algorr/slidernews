import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slidernews/model/articles.dart';
import 'package:slidernews/repository/news_repository.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsApiRepository _repository;
  NewsCubit(this._repository) : super(NewsInitial());

  Future<List<Articles>?> fetch() async {
    final articleList = await _repository.fetchArticles();
    emit(NewsLoadingState());
    if (articleList!.isNotEmpty) {
      print("Article listesi dolu!");
      emit(NewsLoadedState(articleList));
    } else {
      emit(NewsErrorState());
    }
    return null;
  }

  Future<void> init() async {
    await _repository.fetchArticles();
    await fetch();
    //emit(NewsInitial());
  }
}
