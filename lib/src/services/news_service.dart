import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:news_app/src/models/news_models.dart';

final urlService = 'https://newsapi.org/v2';
final apiKey = '35f361ac7d3f48a6aa8de4d8e30cbfe2';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];

  NewsService() {
    this.getTopHeadlines();
  }

  void getTopHeadlines() async {
    final url = '$urlService/top-headlines?country=mx&apiKey=$apiKey';
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);
    this.headlines.addAll(newsResponse.articles);
    notifyListeners();
  }
}
