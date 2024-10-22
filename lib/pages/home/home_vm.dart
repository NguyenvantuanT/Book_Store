import 'dart:async';

import 'package:book_app/models/book_model.dart';
import 'package:book_app/services/book_services.dart';
import 'package:book_app/utils/app_enum.dart';
import 'package:book_app/utils/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeVm extends BaseViewModel {
  Status _status = Status.fiction;
  final searchController = TextEditingController();
  bool isLoading = false;
  bool isLoad = false;
  int currentIndex = 0;

  BookService bookService = BookService();
  List<Book> books = [];
  List<Book> searchBooks = [];

  void init() {
    getBooks();
  }

  void search(String searchText) {
    searchText = searchText.toLowerCase();
    searchBooks = books
        .where((element) => (element.title).toLowerCase().contains(searchText))
        .toList();
    rebuildUi();
  }

  Future<void> getBooks() async {
    isLoading = true;
    rebuildUi();
    await Future.delayed(const Duration(milliseconds: 1600));

    String query = _status.displayName;
    bookService.getDataBook(query, 0, 20).then((value) {
      books = value ?? [];
      searchBooks = [...books];
      isLoading = false;
      search(searchController.text);
      rebuildUi();
    }).catchError((onError) {
      String? error = onError.message;
      print(error ?? 'Server error 😐');
      isLoading = false;
      rebuildUi();
    });
  }

  void updateView(int index) {
    currentIndex = index;
    _status = Status.values[index];
    print(_status.displayName);
    getBooks();
    rebuildUi();

  }
}
