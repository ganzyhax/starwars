import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StarWarApi {
  Future<dynamic> search(name) async {
    try {
      final Dio _dio = Dio();

      Response response = await _dio.get(
        'https://swapi.dev/api/people/?search=' + name,
      );
      Response response2 = await _dio.get(
        'https://swapi.dev/api/starships/?search=' + name,
      );
      Response response3 = await _dio.get(
        'https://swapi.dev/api/planets/?search=' + name,
      );
      var res = response.data['results'];
      res.addAll(response2.data['results']);
      res.addAll(response3.data['results']);
      return res;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return 'error';
    }
  }

  Future<dynamic> fetchSingleFilm(id) async {
    try {
      final Dio _dio = Dio();

      Response response = await _dio.get(id);

      return response.data;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return 'error';
    }
  }

  Future<dynamic> checkExist(name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checker = false;
    print('StartEXist chcek');
    if (prefs.getString('localData') != null) {
      print('have enough');
      final List forCheck = jsonDecode(prefs.getString("localData").toString());

      for (var i = 0; i < forCheck.length; i++) {
        if (forCheck[i]['name'] == name) {
          checker = true;
        }
      }
    }
    return checker;
  }

  Future<dynamic> addPersonFavourite(
      results, name, sex, starships, allFilm) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    results.add({
      "name": name,
      "gender": sex,
      'starships': starships,
    });
    final jsonData = jsonEncode(results);

    prefs.setString("localData", jsonData);

    return results;
  }

  Future<dynamic> addStarshipFavourite(
      results, name, model, manufacturer, passengers, allFilm) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    results.add({
      "name": name,
      "model": model,
      'manufacturer': manufacturer,
      "passengers": passengers,
    });
    final jsonData = jsonEncode(results);

    prefs.setString("localData", jsonData);

    return results;
  }

  Future<dynamic> addFilm(allFilm, name, type, films) async {
    for (var i = 0; i < films.length; i++) {
      var data = {};
      var res = await StarWarApi().fetchSingleFilm(films[i]);
      data['name'] = res['title'];
      data["producer"] = res['producer'];
      data["director"] = res['director'];

      if (type == 0) {
        data["love_people"] = name;
      } else {
        data['love_starship'] = name;
      }
      allFilm.add(data);
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final jsonData = jsonEncode(allFilm);

    prefs.setString("localFilms", jsonData);

    return allFilm;
  }

  Future<dynamic> removeData(results, name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List forCheck = jsonDecode(prefs.getString("localData").toString());
    print(forCheck);
    for (var i = 0; i < forCheck.length; i++) {
      if (forCheck[i]['name'] == name) {
        results.removeAt(i);
        forCheck.removeAt(i);
        final jsonData = jsonEncode(forCheck);
        prefs.setString("localData", jsonData);
      }
    }
    return results;
  }

  Future<dynamic> removeFilm(allFilm, name, type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (type == 0) {
      allFilm.removeWhere((element) => element["love_people"] == name);
    } else {
      allFilm.removeWhere((element) => element["love_starship"] == name);
    }
    final jsonData = jsonEncode(allFilm);

    prefs.setString("localFilms", jsonData);
    return allFilm;
  }

  Future<dynamic> addPlanetFavourite(
    results,
    name,
    diameter,
    population,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var checker = 0;

    results.add({
      "name": name,
      "diameter": diameter,
      'population': population,
    });
    final jsonData = jsonEncode(results);

    prefs.setString("localData", jsonData);

    return results;
  }
}
