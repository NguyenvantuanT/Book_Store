import 'package:book_app/components/app_search_box.dart';
import 'package:book_app/models/book_model.dart';
import 'package:book_app/notifiers/app_status_notifier.dart';
import 'package:book_app/pages/book_show/detail_book.dart';
import 'package:book_app/pages/book_show/status_book.dart';
import 'package:book_app/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            controller: _controller,
            onChange: (value) {},
          ),
        ),
      ),
      body: const BookGridView(),
    );
  }
}

class BookGridView extends StatefulWidget {
  const BookGridView({super.key});

  @override
  State<BookGridView> createState() => _BookGridViewState();
}

class _BookGridViewState extends State<BookGridView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStatusNotifier>(builder: (context, books, child) {
      return FutureBuilder<List<Book>>(
        future: books.fetchBooks(),
        builder: (BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final book = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: book.length,
            itemBuilder: (context, index) {
              return BookCard(book: book[index]);
            },
          );
        },
      );
    });
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
