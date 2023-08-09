import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:war_stars/screens/favourite/bloc/favourite_bloc.dart';
import 'package:war_stars/screens/home/bloc/home_bloc.dart';
import 'package:war_stars/screens/tabbar/bloc/tabbar_bloc.dart';
import 'package:war_stars/screens/tabbar/tabbar_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
              TabbarBloc(context)..add(TabbarLoad()),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              FavouriteBloc()..add(FavouriteLoad()),
        ),
        BlocProvider(
          create: (BuildContext context) => HomeBloc()..add(HomeLoad()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const TabbarScreen(),
      ),
    );
  }
}
