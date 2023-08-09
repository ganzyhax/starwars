part of 'tabbar_bloc.dart';

@immutable
class TabbarEvent {}

class TabChange extends TabbarEvent {
  var index;
  TabChange(this.index);
  @override
  List<Object> get props => [index];
}

class TabbarLoad extends TabbarEvent {}
