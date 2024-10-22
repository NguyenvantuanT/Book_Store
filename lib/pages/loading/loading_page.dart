import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingListPageState();
}

class _LoadingListPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loading'),
      ),
      body: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: true,
          child: const SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                BannerPlaceholder(),
                TitlePlaceholder(width: double.infinity),
                SizedBox(height: 16.0),
                ContentPlaceholder(
                  lineType: ContentLineType.threeLines,
                ),
                SizedBox(height: 16.0),
                TitlePlaceholder(width: 200.0),
                SizedBox(height: 16.0),
                ContentPlaceholder(
                  lineType: ContentLineType.twoLines,
                ),
                SizedBox(height: 16.0),
                TitlePlaceholder(width: 200.0),
                SizedBox(height: 16.0),
                ContentPlaceholder(
                  lineType: ContentLineType.twoLines,
                ),
              ],
            ),
          )),
    );
  }
}

enum ContentLineType { twoLines, threeLines }

class ContentPlaceholder extends StatelessWidget {
  final ContentLineType lineType;

  const ContentPlaceholder({Key? key, required this.lineType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int lineCount = lineType == ContentLineType.twoLines ? 2 : 3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(lineCount, (index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            width: double.infinity, // Full width for each line
            height: 16.0, // Height of each line
            color: Colors.grey.shade300, // Placeholder color
          ),
        );
      }),
    );
  }
}

class TitlePlaceholder extends StatelessWidget {
  final double width;

  const TitlePlaceholder({Key? key, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, // Width is passed from parent
      height: 20.0, // Fixed height for the title placeholder
      color: Colors.grey.shade300, // Placeholder color
    );
  }
}

class BannerPlaceholder extends StatelessWidget {
  const BannerPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Full width of the screen
      height: 200.0, // Height of the banner
      color: Colors.grey.shade300, // Placeholder color
    );
  }
}
