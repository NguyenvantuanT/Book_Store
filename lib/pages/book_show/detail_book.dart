import 'package:book_app/components/app_button.dart';
import 'package:book_app/models/book_model.dart';
import 'package:book_app/pages/book_show/pdf_screen.dart';
import 'package:book_app/pages/home/widgets/app_image_book.dart';
import 'package:book_app/pages/setting/favourite_vm.dart';
import 'package:book_app/resources/app_colors.dart';
import 'package:book_app/utils/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:stacked/stacked.dart';

class DetailBook extends StatelessWidget {
  const DetailBook({super.key, required this.book});
  final Book book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryC,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            _buildMainContent(context),
            _buildBookCover(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 167),
      padding:
          const EdgeInsets.symmetric(horizontal: 20.0).copyWith(bottom: 50.0),
      decoration: const BoxDecoration(
        color: AppColors.bgColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 110),
          _buildBookTitle(context),
          _buildBookMetrics(context),
          _buildActionButtons(context),
          _buildDetailsSection(context),
          _buildDescription(context),
        ],
      ),
    );
  }

  Widget _buildBookCover(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
      top: 70.0,
      left: 0,
      right: 0,
      child: Container(
        height: size.height / 3,
        alignment: Alignment.center,
        child: BookCoverImage(
          thumbnailUrl: book.thumbnailUrl,
          size: size,
        ),
      ),
    );
  }

  Widget _buildBookTitle(BuildContext context) {
    return Column(
      children: [
        Text(
          book.title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: 20,
              ),
        ),
        Text(
          book.authors[0].toUpperCase(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildBookMetrics(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text("Book", style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(width: 30.0),
        _PriceTag(price: book.pageCount.toVND),
        Text(
          "${book.pageCount} pages",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AppButton(
            text: "VIEW ONLINE",
            onTap: () => _openPdfViewer(context),
          ),
          _FavoriteButton(book: book),
        ],
      ),
    );
  }

  void _openPdfViewer(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PdfScreen()),
    );
  }

  Widget _buildDetailsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(title: "Details"),
        _BookDetails(book: book),
      ],
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _SectionTitle(title: "Description"),
        ReadMoreText(
          book.description,
          trimLines: 4,
          colorClickableText: AppColors.black,
          trimMode: TrimMode.Line,
          trimCollapsedText: '...Read More',
          trimExpandedText: ' Less',
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: AppColors.textColor,
          ),
        ),
      ],
    );
  }
}

// class _BookCoverImage extends StatelessWidget {
//   const _BookCoverImage({required this.imageUrl});
//   final String imageUrl;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height / 4,
//       width: MediaQuery.of(context).size.width / 3,
//       decoration: BoxDecoration(
//         color: AppColors.bgColor,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: const [
//           BoxShadow(
//             color: AppColors.shadow,
//             offset: Offset(3.0, 3.0),
//             blurRadius: 6.0,
//           )
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: Image.network(
//           imageUrl,
//           fit: BoxFit.cover,
//           width: double.infinity,
//           errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.error)),
//           loadingBuilder: (_, child, loadingProgress) {
//             return loadingProgress == null
//                 ? child
//                 : const Center(child: CircularProgressIndicator());
//           },
//         ),
//       ),
//     );
//   }
// }

class _PriceTag extends StatelessWidget {
  const _PriceTag({required this.price});
  final String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        price,
        style: Theme.of(context)
            .textTheme
            .labelLarge!
            .copyWith(color: AppColors.bgColor),
      ),
    );
  }
}

class _FavoriteButton extends StackedView<FavouriteVm> {
  const _FavoriteButton({required this.book});
  final Book book;

  @override
  FavouriteVm viewModelBuilder(BuildContext context) => FavouriteVm();
  @override
  Widget builder(BuildContext context, FavouriteVm viewModel, Widget? child) {
    final isFavorite = viewModel.isFavourite(book);
    return AppButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_outline,
        color: isFavorite ? AppColors.red : AppColors.black,
      ),
      text: "WISHLIST",
      onTap: () {
        if (isFavorite) {
          viewModel.removeBook(book);
        } else {
          viewModel.addToFavoriteBook(book);
        }
      },
    );
  }
}

class _BookDetails extends StatelessWidget {
  const _BookDetails({required this.book});
  final Book book;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> details = [
      {'label': 'Author', 'value': book.authors[0]},
      {'label': 'Publisher', 'value': book.publisher},
      {'label': 'Publisher Date', 'value': book.publishedDate},
      {'label': 'Categorie', 'value': book.categories[0]},
    ];

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: details
                .map((detail) => _DetailRow(
                      label: detail['label']!,
                      value: detail['value']!,
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textStyle =
        Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 16.0);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(label, style: textStyle),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: textStyle.copyWith(color: AppColors.grey),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headlineMedium!
            .copyWith(fontSize: 18.0),
      ),
    );
  }
}
