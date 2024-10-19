
import 'package:book_app/components/app_box_shadow.dart';
import 'package:book_app/components/app_simmer.dart';
import 'package:book_app/models/book_model.dart';
import 'package:book_app/notifiers/app_status_notifier.dart';
import 'package:book_app/pages/book_show/detail_book.dart';
import 'package:book_app/resources/app_colors.dart';
import 'package:book_app/utils/app_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatusBook extends StatefulWidget {
  const StatusBook({super.key});

  @override
  State<StatusBook> createState() => _StatusBookState();
}

class _StatusBookState extends State<StatusBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: _buildBookList(),
    );
  }

  Widget _buildBookList() {
    return Consumer<AppStatusNotifier>(builder: (context, books, index) {
      return FutureBuilder<List<Book>>(
        future: books.fetchBooks(),
        builder: (BuildContext context, AsyncSnapshot<List<Book>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 8.0, 10.0),
            shrinkWrap: true,
            separatorBuilder: (_, __) => const SizedBox(height: 20),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final book = snapshot.data![index];
              return BookListItem(book: book);
            },
          );
        },
      );
    });
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

class BookCoverImage extends StatelessWidget {
  final String thumbnailUrl;
  final Size size;

  const BookCoverImage({
    super.key,
    required this.thumbnailUrl,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: thumbnailUrl,
      imageBuilder: (context, imageProvider) => Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          color: AppColors.bgColor,
          border: Border.all(color: AppColors.bgColor),
          borderRadius: BorderRadius.circular(15),
          boxShadow: AppBoxShadow.boxShadow,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (_, __) => const AppSimmmer(),
      errorWidget: (_, __, ___) => const AppSimmmer(),
    );
  }
}
