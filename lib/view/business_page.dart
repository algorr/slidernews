import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:slidernews/consts/main_consts.dart';
import 'package:slidernews/viewmodel/cubit/news_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class BusinessPage extends StatelessWidget {
  const BusinessPage({Key? key}) : super(key: key);

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
      color: Colors.white,
      backgroundColor: MainConsts.liquidRefreshColor,
      onRefresh: () async {
        await context.read<NewsCubit>().fetch();
      },
      child: ListView.builder(
          itemCount: state.apiArticles!.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(37),
                  topRight: Radius.circular(37),
                ),
              ),
              child: InkWell(
                onTap: () {
                  _goUrl(state.apiArticles![index].url);
                },
                child: Column(
                  children: [
                    ArticleImageWidget(context, index),
                    ArticleListTileWidget(index),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ArticlePublishTimeWidget(index),
                        ArticleButtonsWidget()
                      ],
                    ),
                    Divider(
                      thickness: MainConsts.dividerThickness,
                      color: MainConsts.dividerColor,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  SizedBox ArticleImageWidget(BuildContext context, int index) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
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
      ),
    );
  }

  ListTile ArticleListTileWidget(int index) {
    return ListTile(
      title: Text(state.apiArticles![index].title!),
      subtitle: Text(state.apiArticles![index].content ?? ""),
      leading: Text(state.apiArticles![index].author ?? ""),
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
