import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:war_stars/screens/favourite/bloc/favourite_bloc.dart';
import 'package:war_stars/screens/widgets/film_card.dart';
import 'package:war_stars/screens/widgets/person_info_card.dart';
import 'package:war_stars/screens/widgets/planet_info_card.dart';
import 'package:war_stars/screens/widgets/starship_info_card.dart';
import 'package:war_stars/utils/constants.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Избранное'),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: BlocBuilder<FavouriteBloc, FavouriteState>(
          builder: (context, state) {
            if (state is FavouriteLoaded) {
              return Column(
                children: [
                  (state.allFilms.length > 0)
                      ? Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  'Фильмы (любимые персонажи и звездолеты)',
                                  style: Constants.mainTitle,
                                ),
                              )
                            ],
                          ),
                        )
                      : Container(),
                  (state.is_loading == false && state.allFilms.length > 0)
                      ? Container(
                          height: 185,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.allFilms.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.all(10),
                                  child: FilmCard(
                                    data: state.allFilms[index],
                                  ),
                                );
                              }),
                        )
                      : (state.allFilms.length == 0 && state.is_loading != true)
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                children: [
                                  Center(
                                    child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                          color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Загружаем фильмы...',
                                    style: Constants.afterTitleText,
                                  )
                                ],
                              ),
                            ),
                  SizedBox(
                    height: 20,
                  ),
                  (state.allFilms.length > 0)
                      ? new Divider(
                          color: Constants.default_color,
                          thickness: 5,
                        )
                      : Container(),
                  (state.allFilms.length > 0)
                      ? SizedBox(height: 10)
                      : Container(),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.results.length,
                      itemBuilder: (BuildContext context, index) {
                        if (state.results[index]['starships'] != null) {
                          return Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: PersonInfoCard(
                              data: state.results[index],
                            ),
                          );
                        }
                        if (state.results[index]['manufacturer'] != null) {
                          return Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: StarshipInfoCard(
                              data: state.results[index],
                            ),
                          );
                        }
                        if (state.results[index]['diameter'] != null) {
                          return Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: PlanetInfoCard(
                              data: state.results[index],
                            ),
                          );
                        } else {
                          return Text('asfasfasf');
                        }
                      })
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
