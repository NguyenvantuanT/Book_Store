import 'dart:ui';

import 'package:book_app/components/app_box_shadow.dart';
import 'package:book_app/components/app_simmer.dart';
import 'package:book_app/resources/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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