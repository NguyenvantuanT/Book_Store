import 'dart:convert';

import 'package:book_app/constants/app_constants.dart';
import 'package:book_app/models/book_model.dart';
import 'package:http/http.dart' as http;
import 'package:pretty_http_logger/pretty_http_logger.dart';

abstract class ImplBookService {
  Future<List<Book>?> getDataBook(String query, int startIndex, int maxResults);
}

class BookService implements ImplBookService {
  static final httpLog = HttpWithMiddleware.build(middlewares: [
    HttpLogger(logLevel: LogLevel.BODY),
  ]);

  @override
  Future<List<Book>?> getDataBook(
      String query, int startIndex, int maxResults) async {
    const base = AppConstants.baseBook;
    final uri = "$base?q=$query&startIndex=$startIndex&maxResults=$maxResults";
    try {
      http.Response response = await http.get(Uri.parse(uri));
      final data = jsonDecode(response.body);
      if (data['items'] == null) return [];
      return (data['items'] as List)
          .map((book) => Book.fromJson(book))
          .toList();
    } on http.ClientException catch (_) {
      throw Exception();
    }
  }
}
