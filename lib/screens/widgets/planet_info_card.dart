import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:war_stars/screens/favourite/bloc/favourite_bloc.dart';

import '../../utils/constants.dart';

class PlanetInfoCard extends StatelessWidget {
  const PlanetInfoCard({super.key, this.data, this.liked});
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
                  'Планета',
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
                'Диаметр:',
                style: Constants.boldTitle,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                data['diameter'].toString(),
                style: Constants.afterTitleText,
              ),
            ]),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  'Kоличество населения: ',
                  style: Constants.boldTitle,
                ),
                Text(
                  data['population'].toString(),
                  style: Constants.afterTitleText,
                ),
              ],
            ),
          ],
        ),
        InkWell(
          onTap: () {
            BlocProvider.of<FavouriteBloc>(context)
              ..add(FavouritePlanetAdd(
                  data['name'], data['diameter'], data['population']));
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
