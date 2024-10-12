import 'package:book_app/notifiers/app_setting_notifier.dart';
import 'package:book_app/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        title: Text(
          "Favorite page",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: Consumer<AppSettingNotifier>(
        builder: (context, value, child) {
          final favBook = value.favoriteBooks;
          return ListView.separated(
            itemCount: favBook.length,
            separatorBuilder: (_, __) => const Divider(
              color: AppColors.discount,
              indent: 18.0,
              endIndent: 18.0,
            ),
            itemBuilder: (context, index) {
              final book = favBook[index];
              return ListTile(
                leading: Image.network(
                  book.thumbnailUrl,
                  errorBuilder: (_, __, ___) => const Icon(Icons.error),
                ),
                title: Text(
                  book.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                subtitle: Text(book.authors[0],
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: AppColors.grey)),
                trailing: GestureDetector(
                  onTap: () => value.removeBook(book),
                  child: const Icon(Icons.favorite, color: Colors.red),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
