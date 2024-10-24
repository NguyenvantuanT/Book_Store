import 'package:book_app/models/book_model.dart';
import 'package:book_app/pages/home/home_vm.dart';
import 'package:book_app/pages/home/widgets/book_item.dart';
import 'package:book_app/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StatusBook extends StackedView<HomeVm> {
  const StatusBook(
    this.books, {
    super.key,
  });

  final List<Book> books;

  @override
  HomeVm viewModelBuilder(BuildContext context) => HomeVm();

  @override
  void onViewModelReady(HomeVm viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.init();
  }

  @override
  Widget builder(BuildContext context, HomeVm viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: viewModel.isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.textColor,
              ),
            )
          : viewModel.searchBooks.isEmpty
              ? Center(
                  child: Text(
                    viewModel.searchController.text.isEmpty
                        ? 'Books is empty'
                        : 'There is no result',
                    style: const TextStyle(
                        color: AppColors.textColor, fontSize: 20.0),
                  ),
                )
              : SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20.0, 10.0, 8.0, 10.0),
                    shrinkWrap: true,
                    separatorBuilder: (_, __) => const SizedBox(height: 20),
                    itemCount: books.length,
                    itemBuilder: (_, index) => BookListItem(books[index]),
                  ),
                ),
    );
  }
}
