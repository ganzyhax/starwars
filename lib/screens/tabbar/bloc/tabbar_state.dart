part of 'tabbar_bloc.dart';

@immutable
class TabbarState {}

class TabbarInitial extends TabbarState {}

class TabbarLoaded extends TabbarState {
  var index;
  var pages = [];
  var icons = [];
  TabbarLoaded(this.index, this.pages, this.icons);
  @override
  List<Object> get props => [index, pages, icons];
}
