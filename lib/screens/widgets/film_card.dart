import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:war_stars/screens/favourite/bloc/favourite_bloc.dart';

import '../../utils/constants.dart';

class FilmCard extends StatelessWidget {
  const FilmCard({super.key, this.data, this.liked});
  final data;
  final liked;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Constants.default_color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Фильм',
                  style: Constants.mainTitle,
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  'Название:',
                  style: Constants.boldTitle,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  data['name'].toString(),
                  style: Constants.afterTitleText,
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(children: [
              Text(
                'Продюссер:',
                style: Constants.boldTitle,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                data['producer'],
                style: Constants.afterTitleText,
              )
            ]),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  'Режиссер: ',
                  style: Constants.boldTitle,
                ),
                Text(
                  data['director'].toString(),
                  style: Constants.afterTitleText,
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            (data['love_people'] != null)
                ? Row(
                    children: [
                      Text(
                        'Любимый персонаж: ',
                        style: Constants.boldTitle,
                      ),
                      Text(
                        data['love_people'].toString(),
                        style: Constants.afterTitleText,
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Text(
                        'Любимый звездллет: ',
                        style: Constants.boldTitle,
                      ),
                      Text(
                        data['love_starship'].toString(),
                        style: Constants.afterTitleText,
                      ),
                    ],
                  ),
          ],
        ),
        InkWell(
          onTap: () {
            BlocProvider.of<FavouriteBloc>(context)
              ..add(FavouritePersonAdd(
                  data['name'], data['sex'], data['starships'], data['films']));
          },
          child: Align(
            alignment: Alignment.topRight,
            child: Icon(
              Icons.movie_outlined,
              size: 28,
              color: Colors.white,
            ),
          ),
        ),
      ]),
    );
  }
}
