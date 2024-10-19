import 'package:book_app/constants/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:pretty_http_logger/pretty_http_logger.dart';

abstract class ImplBookService{
  Future<http.Response> getDataBook(String query, int startIndex , int maxResults);
}

class BookService implements ImplBookService{
   static final httpLog = HttpWithMiddleware.build(middlewares: [
    HttpLogger(logLevel: LogLevel.BODY),
  ]);

  @override
  Future<http.Response> getDataBook(String query,int startIndex ,int maxResults ) async {
    const base = AppConstants.baseBook;
    final uri = "$base?q=$query&startIndex=$startIndex&maxResults=$maxResults";
    return await http.get(Uri.parse(uri));
  }
  
}
