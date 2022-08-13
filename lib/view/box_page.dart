import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slidernews/view/business_page.dart';
import 'package:slidernews/view/sport_page.dart';
import 'package:slidernews/view/technology_page.dart';
import 'package:slidernews/viewmodel/tabbar_cubit/cubit/tabbar_cubit.dart';

class BoxPage extends StatelessWidget {
  const BoxPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabbarCubit, int>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: AppBottomNaviBar(
            state: state,
          ),
          body: SafeArea(
            child: IndexedStack(
              index: state,
              children: const [
                //All pages app has
                BusinessPage(),
                SportPage(),
                TechnologyPage(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AppBottomNaviBar extends StatelessWidget {
  const AppBottomNaviBar({Key? key, required this.state}) : super(key: key);
  final int state;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: state,
      onTap: (int value) {
        context.read<TabbarCubit>().updateIndex(value);
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.business_rounded), label: 'Business'),
        BottomNavigationBarItem(
            icon: Icon(Icons.sports_rounded), label: 'Sport'),
        BottomNavigationBarItem(
            icon: Icon(Icons.biotech_rounded), label: 'Technology'),
      ],
    );
  }
}
