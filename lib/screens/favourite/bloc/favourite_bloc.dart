import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:war_stars/gateway/gateway.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  FavouriteBloc() : super(FavouriteInitial()) {
    var results = [];
    var allFilms = [];
    bool is_loading = false;
    on<FavouriteEvent>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (event is FavouriteLoad) {
        if (prefs.getString("localData") == null) {
          emit(FavouriteLoaded(results, allFilms, is_loading));
        } else {
          final List data = jsonDecode(prefs.getString("localData").toString());
          final List data2 =
              jsonDecode(prefs.getString("localFilms").toString());

          results = data;
          allFilms = data2;
        }
        emit(FavouriteLoaded(results, allFilms, is_loading));
      }
      if (event is FavouriteStarshipAdd) {
        var check = await StarWarApi().checkExist(event.name);
        if (check == false) {
          is_loading = true;
          var res = await StarWarApi().addStarshipFavourite(results, event.name,
              event.model, event.manufacturer, event.passengers, allFilms);
          results = res;
          emit(FavouriteLoaded(results, allFilms, is_loading));
          var res2 =
              await StarWarApi().addFilm(allFilms, event.name, 1, event.films);
          is_loading = false;
          allFilms = res2;
          emit(FavouriteLoaded(results, allFilms, is_loading));
        } else {
          var res = await StarWarApi().removeData(results, event.name);

          results = res;

          var res2 = await StarWarApi().removeFilm(allFilms, event.name, 1);
          allFilms = res2;
          print(allFilms);
          emit(FavouriteLoaded(results, allFilms, is_loading));
        }
      }

      if (event is FavouritePersonAdd) {
        var check = await StarWarApi().checkExist(event.name);
        if (check == false) {
          var res = await StarWarApi().addPersonFavourite(
              results, event.name, event.sex, event.starships, allFilms);
          results = res;
          is_loading = true;
          emit(FavouriteLoaded(results, allFilms, is_loading));

          var res2 =
              await StarWarApi().addFilm(allFilms, event.name, 0, event.films);
          is_loading = false;
          allFilms = res2;
          emit(FavouriteLoaded(results, allFilms, is_loading));
        } else {
          var res = await StarWarApi().removeData(results, event.name);

          results = res;
          var res2 = await StarWarApi().removeFilm(allFilms, event.name, 0);
          allFilms = res2;
          print(allFilms);
          emit(FavouriteLoaded(results, allFilms, is_loading));
        }
      }
      if (event is FavouritePlanetAdd) {
        var check = await StarWarApi().checkExist(event.name);
        if (check == false) {
          var res = await StarWarApi().addPlanetFavourite(
            results,
            event.name,
            event.diameter,
            event.population,
          );
          results = res;

          emit(FavouriteLoaded(results, allFilms, is_loading));
        } else {
          var res = await StarWarApi().removeData(results, event.name);
          results = res;
          emit(FavouriteLoaded(results, allFilms, is_loading));
        }
      }
    });
  }
}
