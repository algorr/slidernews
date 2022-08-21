import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:slidernews/consts/main_consts.dart';
import 'package:slidernews/model/articles.dart';
import 'package:slidernews/viewmodel/cubit/news_cubit.dart';
import 'package:url_launcher/url_launcher.dart';
import '../viewmodel/tabbar_cubit/cubit/tabbar_cubit.dart';

class BusinessPage extends StatelessWidget {
  const BusinessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _callServiceInit(context);
    return Scaffold(
      body: BlocBuilder<NewsCubit, NewsState>(
        builder: (context, state) {
          // according to news initial state
          if (state is NewsInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
           // according to news loading state
          if (state is NewsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
           // according to news loaded state
          if (state is NewsLoadedState) {
            var apiResult = state.apiArticles;
            var controller = context.read<TabbarCubit>().controller;
            return BlocBuilder<TabbarCubit, int>(
              builder: (context, state) {
                return SafeArea(
                  child: PageView.builder(
                    itemCount: apiResult!.length,
                    scrollDirection: Axis.vertical,
                    controller: controller,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          _goUrl(apiResult[index].url);
                        },
                        child: LiquidPullToRefresh(
                          color: Colors.white,
                          backgroundColor: MainConsts.liquidRefreshColor,
                          onRefresh: () async {
                            await context.read<NewsCubit>().fetch();
                          },
                          child:
                              businessPageAllBodyWidget(size, apiResult, index),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
          return Container(
            color: Colors.red,
          );
        },
      ),
    );
  }

//Contains all page body components
  Container businessPageAllBodyWidget(
      Size size, List<Articles> apiResult, int index) {
    return Container(
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          businessPageImageWidget(apiResult, index),
          businessPageTitleWidget(apiResult, index),
          businessPageBodyWidget(apiResult, index),
          businessPageButtonsWidget(apiResult, index)
        ],
      ),
    );
  }

//Contains button components
  Expanded businessPageButtonsWidget(List<Articles> apiResult, int index) {
    return Expanded(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 8, right: 12, left: 12, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(apiResult[index].publishedAt.toString()),
              const Icon(Icons.favorite_border_rounded),
              const SizedBox(
                width: 4,
              ),
              const Icon(Icons.share_rounded),
              const SizedBox(
                width: 4,
              ),
              const Icon(Icons.more_vert_rounded),
            ],
          ),
        ),
      ),
    );
  }

//Contains body components for api news body
  Padding businessPageBodyWidget(List<Articles> apiResult, int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ListTile(
        title: Text(apiResult[index].title ?? ""),
        subtitle: Text(apiResult[index].content ?? ""),
        leading: Text(apiResult[index].author ?? ""),
      ),
    );
  }

//Contains title component for api news title
  Padding businessPageTitleWidget(List<Articles> apiResult, int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, right: 20, left: 20),
      child: Center(
          child: Text(
        apiResult[index].title ?? "Title",
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      )),
    );
  }

// Contains image component for api image
  Image businessPageImageWidget(List<Articles> apiResult, int index) {
    return Image.network(
      apiResult[index].urlToImage ?? "https://via.placeholder.com/600x400.",
      fit: BoxFit.fill,
    );
  }
}

// execute service init while build method
void _callServiceInit(BuildContext context) {
  BlocProvider.of<NewsCubit>(context).init();
}

// execute url launcher according to api index news url
Future<void> _goUrl(String? url) async {
  if (await canLaunchUrl(Uri.parse(url!))) {
    await launchUrl(Uri.parse(url));
  } else {
    print("URL AÇILAMADI!");
  }
}
