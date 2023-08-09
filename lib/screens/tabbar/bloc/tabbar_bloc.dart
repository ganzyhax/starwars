import 'package:bloc/bloc.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:war_stars/screens/favourite/bloc/favourite_bloc.dart';
import 'package:war_stars/screens/favourite/favourite_screen.dart';
import 'package:war_stars/screens/home/home_screen.dart';

part 'tabbar_event.dart';
part 'tabbar_state.dart';

class TabbarBloc extends Bloc<TabbarEvent, TabbarState> {
  TabbarBloc(BuildContext context) : super(TabbarInitial()) {
    var pages = [];
    var icons = [];
    var index = 0;
    on<TabbarEvent>((event, emit) {
      if (event is TabbarLoad) {
        pages = [HomeScreen(), FavouriteScreen()];
        icons = [
          CustomNavigationBarItem(icon: Icon(Icons.home_filled)),
          CustomNavigationBarItem(icon: Icon(Icons.favorite_border))
        ];
        emit(TabbarLoaded(index, pages, icons));
      }
      if (event is TabChange) {
        index = event.index;
        emit(TabbarLoaded(index, pages, icons));
      }
    });
  }
}
