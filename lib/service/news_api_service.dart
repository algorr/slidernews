import 'dart:convert';
import 'package:slidernews/model/articles.dart';
import 'package:http/http.dart' as http;

class NewsApiService {
  final baseUrlForBusiness =
      "https://newsapi.org/v2/top-headlines?country=tr&category=business&apiKey=513a65f00eac41eb9248f6b58c58e2e4";

final baseUrlForSport =
      "https://newsapi.org/v2/top-headlines?country=tr&category=sport&apiKey=513a65f00eac41eb9248f6b58c58e2e4";

      final baseUrlForTechnology =
      "https://newsapi.org/v2/top-headlines?country=tr&category=technology&apiKey=513a65f00eac41eb9248f6b58c58e2e4";

// Business Articles
  Future<List<Articles>?> fetchAllBusinessArticles() async {
    try {
      final response = await http.get(Uri.parse(baseUrlForBusiness));
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
      throw Exception();
    }
    return null;
  }



// Sports Articles
  Future<List<Articles>?> fetchAllSportArticles() async {
    try {
      final response = await http.get(Uri.parse(baseUrlForSport));
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


  // Technology Articles
  Future<List<Articles>?> fetchAllTechnologyArticles() async {
    try {
      final response = await http.get(Uri.parse(baseUrlForTechnology));
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
