import 'package:flutter/foundation.dart';

class Book {
  final int id; // Make sure id is always provided
  final String bookName;
  final String authorName;
  final int pageNumber;
  final DateTime? datePublished;
  final String cityPublish;

  // Constructor
  Book({
    required this.id,
    required this.bookName,
    required this.authorName,
    required this.pageNumber,
    this.datePublished,
    required this.cityPublish,
  });

  // Factory method to create a Book object from JSON
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] as int,
      bookName: json['bookName'] as String,
      authorName: json['authorName'] as String,
      pageNumber: json['pageNumber'] as int,
      datePublished: json['datePublished'] != null
          ? DateTime.parse(json['datePublished'])
          : null,
      cityPublish: json['cityPublish'] as String,
    );
  }

  // Method to convert a Book object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookName': bookName,
      'authorName': authorName,
      'pageNumber': pageNumber,
      'datePublished': datePublished?.toIso8601String(),
      'cityPublish': cityPublish,
    };
  }
}
