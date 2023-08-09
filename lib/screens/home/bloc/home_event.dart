part of 'home_bloc.dart';

@immutable
class HomeEvent {}

class HomeLoad extends HomeEvent {}

class HomeSearch extends HomeEvent {
  var text;
  HomeSearch(this.text);
  @override
  List<Object> get props => [text];
}

class HomeCleanData extends HomeEvent {}
