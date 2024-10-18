import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppSimmmer extends StatelessWidget {
  const AppSimmmer({
    super.key,
    this.width = 120.0,
    this.height = 120.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(16.0)),
  });

  final double width;
  final double height;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade100,
      highlightColor: Colors.grey.shade400,
      enabled: true,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade400,
          border: Border.all(color: Colors.grey),
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}
