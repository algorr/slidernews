import 'package:slidernews/model/articles.dart';
import 'package:slidernews/service/news_api_service.dart';

class NewsApiRepository {
  final NewsApiService _service;

  NewsApiRepository(this._service);

  Future<List<Articles>?> fetchArticles() async {
    final endList = await _service.fetchAllArticles();
    return endList;
  }
}
