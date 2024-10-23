import 'package:book_app/components/app_search_box.dart';
import 'package:book_app/models/book_model.dart';
import 'package:book_app/pages/book_show/detail_book.dart';
import 'package:book_app/pages/explore/explore_vm.dart';
import 'package:book_app/pages/home/widgets/app_image_book.dart';
import 'package:book_app/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ExplorePage extends StackedView<ExploreVm> {
  const ExplorePage({super.key});

  @override
  ExploreVm viewModelBuilder(BuildContext context) => ExploreVm();

  @override
  void onViewModelReady(ExploreVm viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.init();
  }

  @override
  Widget builder(BuildContext context, ExploreVm viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        title: Text(
          'Explore Books',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: AppSearchBox(
            controller: viewModel.searchController,
            onChanged: viewModel.search,
          ),
        ),
      ),
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
                    style:
                        const TextStyle(color: AppColors.textColor, fontSize: 20.0),
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: viewModel.searchBooks.length,
                  itemBuilder: (context, index) => BookCard(
                    book: viewModel.searchBooks[index],
                  ),
                ),
    );
  }
}

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailBook(
                        book: book,
                      )));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: BookCoverImage(
                thumbnailUrl: book.thumbnailUrl,
                size: MediaQuery.of(context).size,
              ),
            ),
            Container(
              color: AppColors.textForBG,
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(book.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontWeight: FontWeight.bold)),
                    Text(book.authors.join(', '),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontSize: 12.0)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
