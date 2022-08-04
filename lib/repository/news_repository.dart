import 'package:slidernews/model/articles.dart';
import 'package:slidernews/service/news_api_service.dart';

class NewsApiRepository {
  final NewsApiService _service;

  NewsApiRepository(this._service);

// For Business Articles
  Future<List<Articles>?> fetchBusineesArticles() async {
    final endList = await _service.fetchAllBusinessArticles();
    return endList;
  }


// For Sport Articles
  Future<List<Articles>?> fetchSportArticles() async {
    final endList = await _service.fetchAllSportArticles();
    return endList;
  }


// For Technology Articles
  Future<List<Articles>?> fetchTechnologyArticles() async {
    final endList = await _service.fetchAllTechnologyArticles();
    return endList;
  }
}
