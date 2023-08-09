part of 'favourite_bloc.dart';

@immutable
class FavouriteState {}

class FavouriteInitial extends FavouriteState {}

class FavouriteLoaded extends FavouriteState {
  var results = [];
  var allFilms = [];
  bool is_loading = false;
  FavouriteLoaded(this.results, this.allFilms, this.is_loading);
  @override
  List<Object> get props => [results, allFilms, is_loading];
}
