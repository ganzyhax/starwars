part of 'favourite_bloc.dart';

@immutable
class FavouriteEvent {}

class FavouriteLoad extends FavouriteEvent {}

class FavouritePersonAdd extends FavouriteEvent {
  var name;
  var sex;
  var starships;
  var films;
  FavouritePersonAdd(this.name, this.sex, this.starships, this.films);
  @override
  List<Object> get props => [name, sex, starships, films];
}

class FavouriteStarshipAdd extends FavouriteEvent {
  var name;
  var model;
  var manufacturer;
  var passengers;
  var films;
  FavouriteStarshipAdd(
      this.name, this.model, this.manufacturer, this.passengers, this.films);
  @override
  List<Object> get props => [name, model, manufacturer, passengers, films];
}

class FavouritePlanetAdd extends FavouriteEvent {
  var name;
  var diameter;
  var population;

  FavouritePlanetAdd(
    this.name,
    this.diameter,
    this.population,
  );
  @override
  List<Object> get props => [name, diameter, population];
}
