import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slidernews/consts/main_consts.dart';
import 'package:slidernews/repository/news_repository.dart';
import 'package:slidernews/service/news_api_service.dart';
import 'package:slidernews/view/box_page.dart';
import 'package:slidernews/viewmodel/cubit/news_cubit.dart';
import 'package:slidernews/viewmodel/sport_cubit/cubit/sportcubit_cubit.dart';
import 'package:slidernews/viewmodel/tabbar_cubit/cubit/tabbar_cubit.dart';
import 'package:slidernews/viewmodel/technology_cubit/cubit/technologycubit_cubit.dart';
import 'view/business_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeDataOfApp(),
      home: Scaffold(
        appBar: NewsAppBar(),
        body: MultiBlocProvider(providers: [
          BlocProvider(
            create: (context) => NewsCubit(NewsApiRepository(NewsApiService())),
          ),
          BlocProvider(
            create: (context) => TabbarCubit(),
          ),
          BlocProvider(
            create: (context) =>
                SportcubitCubit(NewsApiRepository(NewsApiService())),
          ),
          BlocProvider(
            create: (context) =>
                TechnologycubitCubit(NewsApiRepository(NewsApiService())),
          ),
        ], child: const BoxPage()),
      ),
    );
  }

  AppBar NewsAppBar() {
    return AppBar(
      title: Text(
        MainConsts.appBarTitle,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: MainConsts.appBarTitleColor),
      ),
      centerTitle: false,
      actions: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            minRadius: 25,
            maxRadius: 35,
            backgroundImage: AssetImage("assets/images/person.jpg"),
          ),
        )
      ],
    );
  }

  ThemeData ThemeDataOfApp() {
    return ThemeData(
      scaffoldBackgroundColor: MainConsts.scaffoldBackgroundColor,
      primarySwatch: MainConsts.scaffoldColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: BottomNaviConsts.bottomNaviBackgroundColor,
          selectedItemColor: BottomNaviConsts.activeItemColor,
          unselectedItemColor: BottomNaviConsts.inactiveItemColor),
      appBarTheme: AppBarTheme(
        backgroundColor: MainConsts.appBarColor,
        titleTextStyle: TextStyle(
            color: MainConsts.appBarTextColor,
            fontSize: MainConsts.appBarTextSize),
        iconTheme: IconThemeData(color: MainConsts.appBarTextColor),
      ),
    );
  }
}
