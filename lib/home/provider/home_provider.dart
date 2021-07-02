import 'package:flutter/material.dart';

class HomeProvider extends ValueNotifier<int> {
  HomeProvider() : super(0);

  PageController _pageController = PageController();
  PageController get pageController => _pageController;

  int _indexTab = 0;
  int get indexTab => _indexTab;
  void setIndexTab(int indexTab) {
    _indexTab = indexTab;
    pageController.jumpToPage(indexTab);
    notifyListeners();
  }
}
