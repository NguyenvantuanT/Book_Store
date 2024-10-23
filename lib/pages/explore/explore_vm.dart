import 'package:book_app/models/book_model.dart';
import 'package:book_app/services/book_services.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ExploreVm extends BaseViewModel{
  final searchController = TextEditingController();
  bool isLoading = false;
  bool isLoad = false;

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

    String query = "flutter";
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
}