import 'package:book_app/pages/setting_page/favourite_page.dart';
import 'package:book_app/resources/app_colors.dart';
import 'package:flutter/material.dart';

class SettinsPage extends StatefulWidget {
  const SettinsPage({super.key});

  @override
  State<SettinsPage> createState() => _SettinsPageState();
}

class _SettinsPageState extends State<SettinsPage> {
  List<Map<String, dynamic>> items = [];

  @override
  void initState() {
    super.initState();
    items = [
      {
        'icon': Icons.favorite_outline,
        'title': 'Favorites',
        'function': () => _pushPage(const FavouritePage()),
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
        'icon':Icons.info,
        'title': 'About',
      },
      {
        'icon': Icons.file_copy_outlined,
        'title': 'Open Source Licenses',
      },
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        title: Text(
          "Setting",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: Column(
        children: [
          ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (BuildContext context, int index) => const SizedBox(),
            itemBuilder: (context, index) => ListTile(
              title: Text(items[index]["title"]),
              leading: Icon(items[index]["icon"]),
              onTap: items[index]["function"],
            ),
          )
        ],
      ),
    );
  }


  void _pushPage(Widget page){
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}
