import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:war_stars/screens/favourite/bloc/favourite_bloc.dart';

import '../../utils/constants.dart';

class StarshipInfoCard extends StatelessWidget {
  const StarshipInfoCard({
    super.key,
    this.data,
    this.liked,
  });
  final data;
  final liked;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175,
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
                  'Звездолет',
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
                  'Имя:',
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
                'Модель:',
                style: Constants.boldTitle,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                data['model'].toString(),
                style: Constants.afterTitleText,
              ),
            ]),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  'Производитель: ',
                  style: Constants.boldTitle,
                ),
                Flexible(
                  child: Text(
                    data['manufacturer'].toString(),
                    style: Constants.afterTitleText,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  'Пассажиры: ',
                  style: Constants.boldTitle,
                ),
                Text(
                  data['passengers'].toString(),
                  style: Constants.afterTitleText,
                ),
              ],
            ),
          ],
        ),
        InkWell(
          onTap: () {
            BlocProvider.of<FavouriteBloc>(context)
              ..add(FavouriteStarshipAdd(data['name'], data['model'],
                  data['manufacturer'], data['passengers'], data['films']));
          },
          child: Align(
            alignment: Alignment.topRight,
            child: Icon(
              (liked == false)
                  ? Icons.bookmark_border_sharp
                  : Icons.bookmark_outlined,
              size: 28,
              color: Colors.white,
            ),
          ),
        ),
      ]),
    );
  }
}
