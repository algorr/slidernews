import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slidernews/repository/news_repository.dart';
import 'package:slidernews/service/news_api_service.dart';
import 'package:slidernews/viewmodel/cubit/news_cubit.dart';
import 'view/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData(primarySwatch: Colors.amber,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.black)),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Slider News',style: TextStyle(color: Colors.white),),
            centerTitle: true,
            leading: IconButton(onPressed: (){}, icon: const Icon(Icons.person_rounded,color: Colors.white,)),
          ),
          body: BlocProvider(
            create: (context) => NewsCubit(NewsApiRepository(NewsApiService())),
            child: const HomePage(),
          )),
    );
  }
}
