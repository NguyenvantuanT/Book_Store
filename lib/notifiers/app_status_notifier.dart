
import 'package:book_app/models/book_model.dart';
import 'package:book_app/services/book_services.dart';
import 'package:book_app/utils/app_enum.dart';
import 'package:book_app/utils/app_extension.dart';
import 'package:flutter/material.dart';

class AppStatusNotifier extends ChangeNotifier {
  BookService bookService = BookService();
  Status _status = Status.animeManga;
  Status get status => _status;

  void updateView(int index) {
    _status = Status.values[index];
    print(_status.displayName);
    notifyListeners();
  }

  Future<List<Book>> fetchBooks() async {
    await Future.delayed(const Duration(milliseconds: 1200));
    return bookService.getDataBook(_status.displayName, 0, 20).then((response) {
      // final data = jsonDecode(response.body);
      // if (data['items'] == null) return [];
      // return (data['items'] as List).map((item) => Book.fromJson(item)).toList();
      return [];
    });
  }
}

