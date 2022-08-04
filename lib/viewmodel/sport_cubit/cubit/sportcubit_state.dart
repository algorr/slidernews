part of 'sportcubit_cubit.dart';

abstract class SportcubitState extends Equatable {
  const SportcubitState();

  @override
  List<Object> get props => [];
}

class SportcubitInitial extends SportcubitState {}

class SportLoadingState extends SportcubitState {}

class SportLoadedState extends SportcubitState {
  List<Articles>? apiArticles;

  SportLoadedState(this.apiArticles);
}

class SportErrorState extends SportcubitState {}
