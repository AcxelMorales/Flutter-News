import 'package:flutter/material.dart';
import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/theme/theme.dart';
import 'package:news_app/src/widgets/list_news.dart';
import 'package:provider/provider.dart';

class TabPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
          body: Column(
        children: <Widget>[
          _ListCategories(),
          (!newsService.isLoading)
              ? Expanded(child: ListNews(newsService.articlesSelectedCategory))
              : Padding(
                  padding: EdgeInsets.only(top: 200),
                  child: Center(child: CircularProgressIndicator()))
        ],
      )),
    );
  }
}

class _ListCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;

    return Container(
      child: Container(
        width: double.infinity,
        height: 80.0,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            final categoriName = categories[index].name;

            return Container(
              width: 80,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    _CategoryButton(categories[index]),
                    SizedBox(height: 5),
                    Text(
                        '${categoriName[0].toUpperCase()}${categoriName.substring(1)}',
                        overflow: TextOverflow.ellipsis)
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category category;

  const _CategoryButton(this.category);

  @override
  Widget build(BuildContext context) {
    final newsServiceGlobal = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: () {
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.categorySelected = category.name;
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(
          category.icon,
          color: (newsServiceGlobal.categorySelected == this.category.name)
              ? myTheme.accentColor
              : Colors.black54,
        ),
      ),
    );
  }
}
