import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:slidernews/viewmodel/cubit/news_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _callServiceInit(context);
    return Scaffold(
      body: BlocBuilder<NewsCubit, NewsState>(
        builder: (context, state) {
          if (state is NewsInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is NewsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is NewsLoadedState) {
            return InComingListsWidget(
              state: state,
            );
          }
          return Container(
            color: Colors.red,
          );
        },
      ),
    );
  }
}

void _callServiceInit(BuildContext context) {
  BlocProvider.of<NewsCubit>(context).init();
}

class InComingListsWidget extends StatelessWidget {
  const InComingListsWidget({Key? key, required this.state}) : super(key: key);
  final NewsLoadedState state;
  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      color: Colors.deepPurple,
      backgroundColor: const Color.fromARGB(255, 190, 169, 227),
      onRefresh: () async {
        await context.read<NewsCubit>().fetch();
        print("refresh işlemi başarılı");
      },
      child: ListView.builder(
          itemCount: state.apiArticles!.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 5,
                child: InkWell(
                  onTap: () {
                    _goUrl(state.apiArticles![index].url);
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * .2,
                        child: Image.network(
                          state.apiArticles![index].urlToImage ??
                              "https://picsum.photos/200/300",
                          fit: BoxFit.fill,
                        ),
                      ),
                      ListTile(
                        title: Text(state.apiArticles![index].title!),
                        subtitle: Text(state.apiArticles![index].content ?? ""),
                        leading: Text(state.apiArticles![index].author ?? ""),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Future<void> _goUrl(String? url) async {
    if (await canLaunchUrl(Uri.parse(url!))) {
      await launchUrl(Uri.parse(url));
    } else {
      print("URL AÇILAMADI!");
    }
  }
}
