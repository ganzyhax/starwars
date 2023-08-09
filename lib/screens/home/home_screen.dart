import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:war_stars/screens/favourite/bloc/favourite_bloc.dart';
import 'package:war_stars/screens/home/bloc/home_bloc.dart';
import 'package:war_stars/screens/widgets/person_info_card.dart';
import 'package:war_stars/screens/widgets/planet_info_card.dart';
import 'package:war_stars/screens/widgets/starship_info_card.dart';
import 'package:war_stars/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Container(
              width: 120,
              child: Image.network(
                  'https://lumiere-a.akamaihd.net/v1/images/sw_logo_stacked_2x-52b4f6d33087_7ef430af.png?region=0,0,586,254'),
            ),
          ),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 25,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Constants.default_color,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 22,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                            bottom: 2,
                            right: 5,
                          ),
                          child: SizedBox(
                            width: 230,
                            child: TextField(
                              onChanged: ((value) {
                                if (value.length < 2) {
                                  BlocProvider.of<HomeBloc>(context)
                                    ..add(HomeSearch('restart'));
                                }
                                if (value.length > 2) {
                                  BlocProvider.of<HomeBloc>(context)
                                    ..add(HomeSearch(value));
                                }
                              }),
                              style: TextStyle(color: Colors.white),
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Искать',
                                fillColor: Colors.white,
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Center(
                        child: SizedBox(
                          width: 15,
                          height: 15,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }
                  if (state is HomeLoaded) {
                    return BlocBuilder<FavouriteBloc, FavouriteState>(
                      builder: (context, state2) {
                        if (state2 is FavouriteLoaded) {
                          state2.results.map((e) => print(e));
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: state.results.length,
                              itemBuilder: (BuildContext context, index) {
                                if (state.results[index]['starships'] != null) {
                                  return Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: PersonInfoCard(
                                      liked: (state2.results.any((element) =>
                                              element['name'].contains(state
                                                  .results[index]['name'])))
                                          ? true
                                          : false,
                                      data: state.results[index],
                                    ),
                                  );
                                }
                                if (state.results[index]['manufacturer'] !=
                                    null) {
                                  return Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: StarshipInfoCard(
                                      liked: (state2.results.any((element) =>
                                              element['name'].contains(state
                                                  .results[index]['name'])))
                                          ? true
                                          : false,
                                      data: state.results[index],
                                    ),
                                  );
                                }
                                if (state.results[index]['diameter'] != null) {
                                  return Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: PlanetInfoCard(
                                      liked: (state2.results.any((element) =>
                                              element['name'].contains(state
                                                  .results[index]['name'])))
                                          ? true
                                          : false,
                                      data: state.results[index],
                                    ),
                                  );
                                } else {
                                  return Text('asfasfasf');
                                }
                              });
                        }
                        return Container();
                      },
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ));
  }
}
