import 'package:flutter/material.dart';
import 'package:slidernews/model/articles.dart';

class DetailPage extends StatelessWidget {
  final Articles articles;
  const DetailPage({Key? key, required this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: Text(
          "${articles.author ?? articles.title}",
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            )),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade500,
                    offset: const Offset(4, 4),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                  const BoxShadow(
                    color: Colors.black,
                    offset: Offset(-4, -4),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              height: size.height * .3,
              width: size.width,
              child: Image.network(
                articles.urlToImage ?? "https://picsum.photos/200/300",
                fit: BoxFit.fill,
              ),
            ),
          ),
          Text(
            articles.publishedAt ?? "",
            style: const TextStyle(fontSize: 8),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              articles.title ?? "",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(articles.author ?? ""),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(articles.content ?? ""),
          ),
        ],
      ),
    );
  }
}
