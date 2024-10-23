import 'package:book_app/models/book_model.dart';
import 'package:stacked/stacked.dart';

class FavouriteVm extends BaseViewModel {
  final List<Book> favoriteBooks = [];

  bool isFavourite(Book book) {
    return favoriteBooks.contains(book);
  }

  void addToFavoriteBook(Book book) {
    if (!favoriteBooks.contains(book)) {
      favoriteBooks.add(book);
      notifyListeners();
    }
  }

  void removeBook(Book book) {
    favoriteBooks.removeWhere((e) => e.id == book.id);
    notifyListeners();
  }
}
