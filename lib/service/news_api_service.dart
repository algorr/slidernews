import 'dart:convert';
import 'package:slidernews/model/articles.dart';
import 'package:http/http.dart' as http;

class NewsApiService {
  final baseUrl =
      "https://newsapi.org/v2/top-headlines?country=tr&category=business&apiKey=513a65f00eac41eb9248f6b58c58e2e4";
  Future<List<Articles>?> fetchAllArticles() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        List<Articles> articleList = [];
        for (var item in body['articles']) {
          Articles articles = Articles.fromJson(item);
          articleList.add(articles);
        }
      return articleList;
      }
    } catch (e) {
      print("HATA : $e");
    }
    return null;
  }
}
