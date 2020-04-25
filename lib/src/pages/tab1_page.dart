import 'package:flutter/material.dart';
import 'package:news_app/src/widgets/list_news.dart';
import 'package:provider/provider.dart';

import 'package:news_app/src/services/news_service.dart';

class TabPage1 extends StatefulWidget {
  @override
  _TabPage1State createState() => _TabPage1State();
}

class _TabPage1State extends State<TabPage1> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
  final newsService = Provider.of<NewsService>(context);

    return Scaffold(
      body: (newsService.headlines.length == 0)
      ? Center(child: CircularProgressIndicator())
      : ListNews(newsService.headlines)
    );
  }

  @override
  bool get wantKeepAlive => true;
}