part of 'news_cubit.dart';

abstract class NewsState extends Equatable {}

class NewsInitial extends NewsState {
  @override
  List<Object?> get props => [];
}

class NewsLoadingState extends NewsState {
  @override
  List<Object?> get props => [];
}

class NewsLoadedState extends NewsState {
  final List<Articles>? apiArticles;

  NewsLoadedState(this.apiArticles);

  @override
  List<Object?> get props => [apiArticles];
}

class NewsErrorState extends NewsState {
  @override
  List<Object?> get props => [];
}