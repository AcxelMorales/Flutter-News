import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/models/news_models.dart';

final urlService = 'https://newsapi.org/v2';
final apiKey = '35f361ac7d3f48a6aa8de4d8e30cbfe2';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  String _categorySelected = 'business';
  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  bool _isLoading = true;

  NewsService() {
    this.getTopHeadlines();

    categories.forEach((item) {
      this.categoryArticles[item.name] = List();
    });

    this.getArticleByCategory(this._categorySelected);
  }

  bool get isLoading => this._isLoading;

  get categorySelected => this._categorySelected;

  set categorySelected(String category) {
    this._categorySelected = category;
    this._isLoading = true;
    this.getArticleByCategory(category);
    notifyListeners();
  }

  List<Article> get articlesSelectedCategory =>
      this.categoryArticles[this.categorySelected];

  void getTopHeadlines() async {
    final url = '$urlService/top-headlines?country=mx&apiKey=$apiKey';
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);
    this.headlines.addAll(newsResponse.articles);

    notifyListeners();
  }

  getArticleByCategory(String category) async {
    if (this.categoryArticles[category].length > 0) {
      this._isLoading = false;
      notifyListeners();
      return this.categoryArticles[category];
    }

    final url =
        '$urlService/top-headlines?country=mx&apiKey=$apiKey&category=$category';
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);
    this.categoryArticles[category].addAll(newsResponse.articles);

    this._isLoading = false;
    notifyListeners();
  }
}
