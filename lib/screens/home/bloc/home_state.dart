part of 'home_bloc.dart';

@immutable
class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoaded extends HomeState {
  var results = [];

  HomeLoaded(this.results);
  @override
  List<Object> get props => [results];
}

class HomeLoading extends HomeState {}
