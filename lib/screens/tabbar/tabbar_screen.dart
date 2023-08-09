import 'dart:async';

import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:war_stars/screens/favourite/bloc/favourite_bloc.dart';
import 'package:war_stars/screens/home/bloc/home_bloc.dart';
import 'package:war_stars/screens/tabbar/bloc/tabbar_bloc.dart';

class TabbarScreen extends StatefulWidget {
  const TabbarScreen({Key? key}) : super(key: key);

  @override
  _TabbarScreenState createState() => _TabbarScreenState();
}

class _TabbarScreenState extends State<TabbarScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabbarBloc, TabbarState>(
      builder: (context, state) {
        if (state is TabbarLoaded) {
          return Scaffold(
              backgroundColor: Colors.black,
              body: Center(child: state.pages[state.index]),
              bottomNavigationBar: CustomNavigationBar(
                  currentIndex: state.index,
                  onTap: (index) {
                    context.read<HomeBloc>().add(HomeCleanData());
                    BlocProvider.of<TabbarBloc>(context)..add(TabChange(index));
                  },
                  selectedColor: Colors.white,
                  unSelectedColor: Colors.grey,
                  backgroundColor: Colors.black,
                  strokeColor: Colors.white,
                  items: [
                    CustomNavigationBarItem(icon: Icon(Icons.home_filled)),
                    CustomNavigationBarItem(icon: Icon(Icons.favorite_border)),
                  ]));
        }
        return Container();
      },
    );
  }
}
