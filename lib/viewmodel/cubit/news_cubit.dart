import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slidernews/model/articles.dart';
import 'package:slidernews/repository/news_repository.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsApiRepository _repository;
  NewsCubit(this._repository) : super(NewsInitial());
   int index = 0;
  

  Future<List<Articles>?> fetch() async {
    final articleList = await _repository.fetchBusineesArticles();
    emit(NewsLoadingState());
    print(state);
    if (articleList!.isNotEmpty) {
      emit(NewsLoadedState(articleList));
      print(state);
    } else {
      emit(NewsErrorState());
      print(state);
    }
    return null;
  }

  Future<void> init() async {
    await _repository.fetchBusineesArticles();
    await fetch();
    //emit(NewsInitial());
  }

  void updateIndex(){
    index += index;
    emit(NewsUpdateIndex(index));
  }
}
