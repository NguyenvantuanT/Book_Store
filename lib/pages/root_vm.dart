import 'package:book_app/pages/explore/explore_page.dart';
import 'package:book_app/pages/home/home_page.dart';
import 'package:book_app/pages/setting/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RootVm extends BaseViewModel{
  int _selectIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    ExplorePage(),
    SettingPage(),
  ];

  final List<String> _namePages = [
    "Home",
    "Explore",
    "Settings",
  ];

  final List<IconData> _iconPages = const [
    Icons.home_outlined,
    Icons.explore_outlined,
    Icons.settings_outlined
  ];


  int get selectIndex => _selectIndex;

  void setIndex(int selectIndex) {
    _selectIndex = selectIndex;
    rebuildUi();
  }

  Widget getPage(int selectIndex) {
    return _pages[selectIndex];
  }

  String getName(int selectIndex) {
    return _namePages[selectIndex];
  }

  IconData getIcon(int selectIndex) {
    return _iconPages[selectIndex];
  }
}