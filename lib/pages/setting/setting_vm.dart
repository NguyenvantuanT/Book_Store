import 'package:book_app/pages/setting/favourite_page.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SettingVm extends BaseViewModel {
  List<Map<String, dynamic>> items = [];

  void init() {
    items = [
      {
        'icon': Icons.favorite_outline,
        'title': 'Favorites',
        'widget': const FavouritePage(),
      },
      {
        'icon': Icons.download,
        'title': 'Downloads',
      },
      {
        'icon': Icons.mode,
        'title': 'Dark Mode',
        'function': null,
      },
      {
        'icon': Icons.info,
        'title': 'About',
      },
      {
        'icon': Icons.file_copy_outlined,
        'title': 'Open Source Licenses',
      },
    ];
  }
}
