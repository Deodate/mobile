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

  void _refreshData() async {
    final data = await SQLHelper.getData();
    setState(() {
      _allData = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _addData() async {
    // Collecting values from text controllers
    final bookName = _bookNameController.text;
    final authorName = _authorNameController.text;
    final pageNumber = int.tryParse(_pageNumberController.text) ?? 0;
    final datePublished = _datePublishedController.text;
    final cityPublish = _cityPublishController.text;

    // Call SQLHelper.createData with collected values
    await SQLHelper.createData(
      bookName,
      authorName.isEmpty ? null : authorName,
      pageNumber,
      datePublished.isEmpty ? null : datePublished,
      cityPublish.isEmpty ? null : cityPublish,
    );

    // Refresh the data to update the UI
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
          content: Text('Book deleted successfully'),
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

  // Controllers for text fields
  final TextEditingController _bookNameController = TextEditingController();
  final TextEditingController _authorNameController = TextEditingController();
  final TextEditingController _pageNumberController = TextEditingController();
  final TextEditingController _datePublishedController =
      TextEditingController();
  final TextEditingController _cityPublishController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFECEAF4),
      appBar: AppBar(
        title: Text("MY BOOK LIBRARY"),
        ),
        body: _isLoading ? const Center(child: CircularProgressIndicator(),)
    );
  }
}
