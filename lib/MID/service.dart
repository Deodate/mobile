import 'dart:convert';
import 'package:http/http.dart' as http;
import 'book_model.dart';

class Services {
  static const String ROOT = 'http://localhost/mobileflutter/libraryBook.php';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_BOOK_ACTION = 'ADD_BOOK';
  static const _UPDATE_BOOK_ACTION = 'UPDATE_BOOK';
  static const _DELETE_BOOK_ACTION = 'DELETE_BOOK';

  // Method to create the table Book
  static Future<String> createTable() async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _CREATE_TABLE_ACTION; 
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Create Table Response: ${response.body}');
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return "error";
    }
  }

  // Method to get all books
  static Future<List<Book>> getBooks() async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Get Books Response: ${response.body}');
      if (response.statusCode == 200) {
        List<Book> list = parseResponse(response.body);
        return list;
      } else {
        print('Failed to get books: ${response.reasonPhrase}');
        return [];
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return [];
    }
  }

  // Method to parse JSON response into a list of Book objects
  static List<Book> parseResponse(String responseBody) {
    final List<dynamic> parsed = json.decode(responseBody);
    return parsed.map((json) => Book.fromJson(json)).toList();
  }

  // Method to add a book to the database
  static Future<String> addBook(Book book, {required String authorName, required String bookName, required int pageNumber, required DateTime datePublished, required String cityPublish, required int id}) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _ADD_BOOK_ACTION;
      map['bookName'] = book.bookName;
      map['authorName'] = book.authorName;
      map['pageNumber'] = book.pageNumber;
      map['datePublished'] = book.datePublished?.toIso8601String(); // Convert DateTime to ISO string
      map['cityPublish'] = book.cityPublish;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Add Book Response: ${response.body}');
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return 'error';
    }
  }

  // Method to update a book in the database
  static Future<String> updateBook(Book book, {required String bookName, required String authorName, required int id, required int pageNumber, required DateTime datePublished, required String cityPublish}) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _UPDATE_BOOK_ACTION;
      map['id'] = book.id;
      map['bookName'] = book.bookName;
      map['authorName'] = book.authorName;
      map['pageNumber'] = book.pageNumber;
      map['datePublished'] = book.datePublished?.toIso8601String(); // Convert DateTime to ISO string
      map['cityPublish'] = book.cityPublish;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Update Book Response: ${response.body}');
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return 'error';
    }
  }

  // Method to delete a book from the database
  static Future<String> deleteBook(int id) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _DELETE_BOOK_ACTION;
      map['id'] = id;
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('Delete Book Response: ${response.body}');
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return 'error';
    }
  }

  static getNextBookId() {}
}
