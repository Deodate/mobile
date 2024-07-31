import 'dart:async';

import 'package:first_quiz/MID/book_registration.dart';
import 'package:flutter/material.dart';
import 'sql_helper.dart';

class Books extends StatefulWidget {
  @override
  State<Books> createState() => _BooksState();
}

class _BooksState extends State<Books> {
  List<Map<String, dynamic>> _allData = [];

  bool _isLoading = true;
  bool _isSearching = false;

// Remove these lines
Timer? _debounce;
// ...


  final TextEditingController _searchController = TextEditingController();
    List<Map<String, dynamic>> _allBooks = [];
  List<Map<String, dynamic>> _displayedBooks = [];

 void _searchData(String query) {
  setState(() {
    if (query.isEmpty) {
      _displayedBooks = List.from(_allData);
    } else {
      _displayedBooks = _allData.where((book) =>
        book['bookName'].toString().toLowerCase().contains(query.toLowerCase()) ||
        book['authorName'].toString().toLowerCase().contains(query.toLowerCase())
      ).toList();
    }
  });
}

  @override
  void initState() {
    super.initState();
     _refreshData();
  }

  void _refreshData() async {
  final data = await SQLHelper.getData();
  setState(() {
    _allData = data;
    _displayedBooks = List.from(_allData);
    _isLoading = false;
  });
}


  Future<void> _addData() async {
    final bookName = _bookNameController.text;
    final authorName = _authorNameController.text;
    final pageNumber = int.tryParse(_pageNumberController.text) ?? 0;
    final datePublished = _datePublishedController.text;
    final cityPublish = _cityPublishController.text;

    await SQLHelper.createData(
      bookName,
      authorName.isEmpty ? null : authorName,
      pageNumber,
      datePublished.isEmpty ? null : datePublished,
      cityPublish.isEmpty ? null : cityPublish,
      null
    );

    _refreshData();
  }

  Future<void> _updateData(int id) async {
    final bookName = _bookNameController.text;
    final authorName = _authorNameController.text;
    final pageNumber = int.tryParse(_pageNumberController.text) ?? 0;
    final datePublished = _datePublishedController.text;
    final cityPublish = _cityPublishController.text;

    await SQLHelper.updateData(
      id,
      bookName,
      authorName.isEmpty ? null : authorName,
      pageNumber,
      datePublished.isEmpty ? null : datePublished,
      cityPublish.isEmpty ? null : cityPublish,
    );

    _refreshData();
  }

  void _deleteData(int id) async {
    try {
      await SQLHelper.deleteData(id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Book deleted successfully!'),
          backgroundColor: Colors.redAccent,
        ),
      );
      _refreshData();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to delete the book'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  final TextEditingController _bookNameController = TextEditingController();
  final TextEditingController _authorNameController = TextEditingController();
  final TextEditingController _pageNumberController = TextEditingController();
  final TextEditingController _datePublishedController =
      TextEditingController();
  final TextEditingController _cityPublishController = TextEditingController();

  void showBottomSheet(int? id) async {
    if (id != null) {
      final existingData =
          _allData.firstWhere((element) => element['id'] == id);

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              top: 30,
              left: 15,
              right: 15,
              bottom: MediaQuery.of(context).viewInsets.bottom + 50,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // **Updated: Added title for the form**
                const Text(
                  'Register a Book', // Title text
                  style: TextStyle(
                    fontSize: 20, // Font size for the title
                    fontWeight:
                        FontWeight.bold, // Bold font weight for the title
                    color: Colors.black, // Black color for the title text
                  ),
                ),
                const SizedBox(
                    height: 20), // Spacing between title and form fields
                TextField(
                  controller: _bookNameController
                    ..text = existingData['bookName'] ?? '',
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Book Name',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _authorNameController
                    ..text = existingData['authorName'] ?? '',
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Author Name',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _pageNumberController
                    ..text = existingData['pageNumber']?.toString() ?? '',
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Page Number',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _datePublishedController
                    ..text = existingData['datePublished'] ?? '',
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Date Published',
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _cityPublishController
                    ..text = existingData['cityPublish'] ?? '',
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'City Published',
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _updateData(id);
                        Navigator.of(context).pop(); // Close the bottom sheet
                      },
                      child: Text('Update'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.green, // Black text color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Rectangle shape
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        _deleteData(id);
                        Navigator.of(context).pop(); // Close the bottom sheet
                      },
                      child: Text('Delete'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.red, // Black text color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Rectangle shape
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      );
    } else {
      // Show a blank form if id is null (for adding new data)
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              top: 30,
              left: 15,
              right: 15,
              bottom: MediaQuery.of(context).viewInsets.bottom + 50,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _bookNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Book Name',
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _authorNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Author Name',
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _pageNumberController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Page Number',
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _datePublishedController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Date Published',
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _cityPublishController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'City Published',
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (id == null) {
                        await _addData();
                      } else {
                        await _updateData(id);
                      }
                      _bookNameController.text = "";
                      _authorNameController.text = "";
                      _pageNumberController.text = "";
                      _datePublishedController.text = "";
                      _cityPublishController.text = "";
                      Navigator.of(context).pop(); // Close the bottom sheet
                      print("Data Added!");
                    },
                    child: Text(id == null ? 'Add' : 'Update'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: id == null
                          ? Colors.blue
                          : Colors
                              .green, // Blue for Add button, Green for Update
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8), // Rectangle shape
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Color(0xFF317AF7),
    appBar: AppBar(
      title: _isSearching
      ? TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.black),
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
          style: TextStyle(color: Colors.black),
          onChanged: (query) {
            _searchData(query);
          },
        )
          : const Text("MY BOOK LIBRARY"),
      actions: [
        IconButton(
          icon: Icon(_isSearching ? Icons.close : Icons.search),
          color: _isSearching ? Colors.red : Colors.blue,
          onPressed: () {
            setState(() {
              _isSearching = !_isSearching;
              if (!_isSearching) {
                _searchController.clear();
                _searchData('');
              }
              });
            },
          ),
        ],
      ),
      body: _isLoading
    ? const Center(child: CircularProgressIndicator())
    : ListView.builder(
       itemCount: _displayedBooks.length,
        itemBuilder: (context, index) {
         final book = _displayedBooks[index];
          return Card(
            margin: const EdgeInsets.all(15),
            child: ListTile(
              title: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  book['bookName'] ?? 'No Title',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              subtitle: Text(
                'Author: ${book['authorName'] ?? 'Unknown'}\n'
                'Pages: ${book['pageNumber'] ?? 'N/A'}\n'
                'Published: ${book['datePublished'] ?? 'Unknown'}\n'
                'City: ${book['cityPublish'] ?? 'Unknown'}',
              ),
              trailing: Wrap(
                spacing: 12,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      showBottomSheet(book['id']);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _deleteData(book['id']);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () =>
            showBottomSheet(null), // Call the function to show the bottom sheet
        child: Text('Add'), // Text for the button
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.yellow, // Text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Rectangle shape
          ),
          padding: EdgeInsets.symmetric(
              horizontal: 20, vertical: 10), // Padding inside the button
        ),
      ),
    );
  }
}