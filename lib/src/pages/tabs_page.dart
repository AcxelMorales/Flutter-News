import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:news_app/src/pages/tab1_page.dart';
import 'package:news_app/src/pages/tab2_page.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavigationModel(),
      child: Scaffold(
        body: _Pages(),
        bottomNavigationBar: _Navigation(),
      ),
    );
  }
}

class _Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);

    return BottomNavigationBar(
      currentIndex: navigationModel.currentPage,
      onTap: (i) => navigationModel.currentPage = i,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), title: Text('For you')),
        BottomNavigationBarItem(
            icon: Icon(Icons.public), title: Text('Headers')),
      ],
    );
  }
}

class _Pages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);

    return PageView(
      // physics: BouncingScrollPhysics(),
      controller: navigationModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        TabPage1(),
        TabPage2(),
      ],
    );
  }
}

class _NavigationModel with ChangeNotifier {
  int _currentPage = 0;
  PageController _pageController = PageController();

  int get currentPage => this._currentPage;

  set currentPage(int value) {
    this._currentPage = value;
    this._pageController.animateToPage(value, duration: Duration(milliseconds: 250), curve: Curves.easeInOut);
    notifyListeners();
  }

  PageController get pageController => this._pageController;
}
