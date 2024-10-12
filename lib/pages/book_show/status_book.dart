import 'package:book_app/models/book_model.dart';
import 'package:book_app/notifiers/app_book_explore.dart';
import 'package:book_app/pages/book_show/detail_book.dart';
import 'package:book_app/services/book_services.dart';
import 'package:book_app/resources/app_colors.dart';
import 'package:book_app/utils/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExploreProvider(
        context.read<BookService>(),
      )..loadMoreBooks(),
      child: const StatusBook(),
    );
  }
}

class StatusBook extends StatefulWidget {
  const StatusBook({super.key});

  @override
  State<StatusBook> createState() => _StatusBookState();
}

class _StatusBookState extends State<StatusBook> {
  final ScrollController _scrollController = ScrollController();
  
  @override
  void initState() {
    super.initState();
    _setupScrollController();
  }

  void _setupScrollController() {
    _scrollController.addListener(() {
      _loadMoreIfNeeded();
    });
  }

  void _loadMoreIfNeeded() {
    if (_isNearBottom) {
      context.read<ExploreProvider>().loadMoreBooks();
    }
  }

  bool get _isNearBottom {
    return _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Consumer<ExploreProvider>(
        builder: (context, provider, _) {
          if (provider.books.isEmpty) {
            return _buildEmptyState(provider);
          }
          return _buildBookList(provider);
        },
      ),
    );
  }

  Widget _buildEmptyState(ExploreProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (provider.error != null) {
      return _buildErrorState(provider);
    }
    return const SizedBox.shrink();
  }

  Widget _buildErrorState(ExploreProvider provider) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(provider.error!),
          ElevatedButton(
            onPressed: provider.refreshBooks,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildBookList(ExploreProvider provider) {
    return ListView.separated(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 8.0, 10.0),
      shrinkWrap: true,
      separatorBuilder: (_, __) => const SizedBox(height: 20),
      itemCount: provider.books.length + (provider.hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == provider.books.length) {
          return const Center(child: CircularProgressIndicator());
        }
        return BookListItem(book: provider.books[index]);
      },
    );
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
      padding: const EdgeInsets.all(10.0),
      height: size.height / 4,
      decoration: BoxDecoration(
        color: AppColors.textForBG,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: GestureDetector(
        onTap: () => _navigateToDetail(context),
        child: Row(
          children: [
            BookCoverImage(
              thumbnailUrl: book.thumbnailUrl,
              size: size,
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
          style:  const TextStyle(
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
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgColor,
        border: Border.all(color: AppColors.bgColor),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            offset: Offset(3.0, 3.0),
            blurRadius: 6.0,
          )
        ],
      ),
      height: size.height * 0.4,
      width: size.width * 0.30,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          thumbnailUrl,
          fit: BoxFit.cover,
          width: double.infinity,
          errorBuilder: (context, error, stackTrace) =>
              const Center(child: Icon(Icons.error)),
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}