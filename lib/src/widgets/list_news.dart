import 'package:flutter/material.dart';

import 'package:news_app/src/models/news_models.dart';
import 'package:news_app/src/theme/theme.dart';

class ListNews extends StatelessWidget {
  final List<Article> news;

  ListNews(this.news);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: this.news.length,
      itemBuilder: (BuildContext context, int index) {
        return _New(neew: this.news[index], index: index);
      },
    );
  }
}

class _New extends StatelessWidget {
  final Article neew;
  final int index;

  const _New({@required this.neew, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.0),
      child: Column(
        children: <Widget>[
          _CardTopBar(neew: neew, index: index),
          _CardTitle(neew),
          _CardImage(neew),
          _CardBody(neew),
          _CardButtons(),
          SizedBox(height: 10.0),
          Divider(),
        ],
      ),
    );
  }
}

class _CardTopBar extends StatelessWidget {
  final Article neew;
  final int index;

  const _CardTopBar({@required this.neew, @required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: <Widget>[
          Text('${index + 1}. ', style: TextStyle(color: myTheme.accentColor)),
          Text('${neew.source.name}.')
        ],
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  final Article neew;

  const _CardTitle( this.neew);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(neew.title, style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w700
      )),
    );
  }
}

class _CardImage extends StatelessWidget {
  final Article neew;

  const _CardImage(this.neew);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0), bottomRight: Radius.circular(50.0)),
        child: Container(
          child: (neew.urlToImage != '(none)') ? FadeInImage(
            image: NetworkImage(neew.urlToImage),
            placeholder: AssetImage('assets/img/giphy.gif'),
          ) : Image(image: AssetImage('assets/img/no-image.png'),)
        ),
      ),
    );
  }
}

class _CardBody extends StatelessWidget {
  final Article neew;

  const _CardBody(this.neew);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(neew.description),
    );
  }
}

class _CardButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          RawMaterialButton(
            onPressed: () {},
            fillColor: Colors.redAccent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            child: Icon(Icons.star_border),
          ),
          RawMaterialButton(
            onPressed: () {},
            fillColor: Colors.blueAccent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            child: Icon(Icons.more),
          ),
        ],
      ),
    );
  }
}