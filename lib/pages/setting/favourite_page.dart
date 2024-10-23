import 'package:book_app/pages/setting/favourite_vm.dart';
import 'package:book_app/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class FavouritePage extends StackedView<FavouriteVm> {
  const FavouritePage({super.key});

  @override
  FavouriteVm viewModelBuilder(BuildContext context) => FavouriteVm();

  @override
  Widget builder(BuildContext context, FavouriteVm viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Favorite page",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: ListView.separated(
        itemCount: viewModel.favoriteBooks.length,
        separatorBuilder: (_, __) => const Divider(
          color: AppColors.discount,
          indent: 18.0,
          endIndent: 18.0,
        ),
        itemBuilder: (context, index) {
          final book = viewModel.favoriteBooks[index];
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
              onTap: () => viewModel.removeBook(book),
              child: const Icon(Icons.favorite, color: Colors.red),
            ),
          );
        },
      ),
    );
  }
}
