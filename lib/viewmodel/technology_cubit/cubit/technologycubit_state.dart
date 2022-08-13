part of 'technologycubit_cubit.dart';

abstract class TechnologycubitState extends Equatable {
  const TechnologycubitState();

  @override
  List<Object> get props => [];
}

class TechnologycubitInitial extends TechnologycubitState {}

class TechnologyLoadingState extends TechnologycubitState {}

class TechnologyLoadedState extends TechnologycubitState {
 final List<Articles>? apiArticles;

  const TechnologyLoadedState(this.apiArticles);
}

class TechnologyErrorState extends TechnologycubitState {}
