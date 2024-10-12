import 'package:book_app/models/book_model.dart';
import 'package:flutter/material.dart';

class AppSettingNotifier extends ChangeNotifier {
  final List<Book> _favoriteBooks = [];
  List<Book> get favoriteBooks => _favoriteBooks;

  bool isFavourite(Book book){
    return  _favoriteBooks.contains(book);
  }

  void addToFavoriteBook(Book book) {
  if (!_favoriteBooks.contains(book)) {
    _favoriteBooks.add(book);
    notifyListeners();
  }
}

  void removeBook(Book book){
    _favoriteBooks.removeWhere((e) => e.id == book.id);
    notifyListeners();
  }


}
