import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:slidernews/viewmodel/sport_cubit/cubit/sportcubit_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class SportPage extends StatelessWidget {
  const SportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _callServiceInit(context);
    return Scaffold(
      body: BlocBuilder<SportcubitCubit, SportcubitState>(
        builder: (context, state) {
          if (state is SportcubitInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SportLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SportLoadedState) {
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
  BlocProvider.of<SportcubitCubit>(context).init();
}

class InComingListsWidget extends StatelessWidget {
  const InComingListsWidget({Key? key, required this.state}) : super(key: key);
  final SportLoadedState state;
  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      color: Colors.deepPurple,
      backgroundColor: const Color.fromARGB(255, 190, 169, 227),
      onRefresh: () async {
        await context.read<SportcubitCubit>().fetch();
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
                        child: 
                        state.apiArticles![index].urlToImage !=null ? 
                        Image.network(
                          state.apiArticles![index].urlToImage ??
                              "https://picsum.photos/200/300",
                          fit: BoxFit.fill,
                           errorBuilder: (context, object, stacktrace) {
                return Container(color: Colors.red);
              },
                        ) : Image.asset("assets/images/logo.png"),
                      ),
                      ListTile(
                        title: Text(state.apiArticles![index].title!),
                        subtitle: Text(state.apiArticles![index].content ?? ""),
                        leading: Text(state.apiArticles![index].author ?? ""),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ArticlePublishTimeWidget(index),
                          ArticleButtonsWidget()
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Row ArticleButtonsWidget() {
    return Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Icon(Icons.favorite_border_rounded),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(Icons.share_outlined),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(Icons.more_vert_rounded),
                          ],
                        );
  }

  Row ArticlePublishTimeWidget(int index) {
    return Row(
                          children: [
                            //Text(state.apiArticles![index].author!),
                            Text(state.apiArticles![index].publishedAt!),
                          ],
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
