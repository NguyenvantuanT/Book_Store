import 'package:book_app/models/book_model.dart';
import 'package:book_app/pages/book_show/detail_book.dart';
import 'package:book_app/pages/home/home_vm.dart';
import 'package:book_app/pages/home/widgets/app_image_book.dart';
import 'package:book_app/resources/app_colors.dart';
import 'package:book_app/utils/app_extension.dart';
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
                  color: AppColors.primaryD,
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
                      itemBuilder: (context, index) => BookListItem(
                        book: books[index],
                      ),
                    ),
                  ));
  }
}

class BookListItem extends StatelessWidget {
  final Book book;

  const BookListItem({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      height: size.height / 3,
      decoration: BoxDecoration(
        color: AppColors.textForBG,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: GestureDetector(
        onTap: () => _navigateToDetail(context),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.25,
              width: size.width * 0.30,
              child: BookCoverImage(
                thumbnailUrl: book.thumbnailUrl,
                size: size,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 40.0,
                ),
                child: BookDetails(book: book),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailBook(book: book),
      ),
    );
  }
}

class BookDetails extends StatelessWidget {
  final Book book;

  const BookDetails({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          book.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
          book.authors[0],
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppColors.blue,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
        Expanded(
          child: Text(
            "\$ ${(book.pageCount).toVND}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      ],
    );
  }
}


