import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:war_stars/gateway/gateway.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    var results = [];
    var fullRes = [];
    List favouritePersonList = [];
    List favouriteStarshipList = [];
    on<HomeEvent>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (event is HomeLoad) {
        emit(HomeLoading());
        if (prefs.getString("localData") == null) {
          favouritePersonList = [];
        } else {
          favouritePersonList =
              jsonDecode(prefs.getString("localData").toString());
          favouriteStarshipList =
              jsonDecode(prefs.getString("localFilms").toString());
        }
        emit(HomeLoaded(
          results,
        ));
      }
      if (event is HomeSearch) {
        if (event.text == 'restart') {
          results = [];
          emit(HomeLoaded(
            results,
          ));
        } else {
          emit(HomeLoading());

          var res = await StarWarApi().search(event.text);
          var data = res;
          results = data
              .where((el) => el['name']
                  .toString()
                  .toLowerCase()
                  .contains(event.text.toString().toLowerCase()))
              .toList();
          emit(HomeLoaded(
            results,
          ));
        }
      }
      if (event is HomeCleanData) {
        results = [];
        emit(HomeLoaded(
          results,
        ));
      }
    });
  }
}
