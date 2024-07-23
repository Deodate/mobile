import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_quiz/theme_notifier.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({Key? key}) : super(key: key);

  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _bookNameController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _pagesController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  bool _isDrawerOpen = false;
  bool _isSearching = false;
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  String _selectedMenuItem = 'All Books';

  void _toggleDrawer() => setState(() {
        _isDrawerOpen = !_isDrawerOpen;
      });

  void _closeDrawer() => setState(() {
        _isDrawerOpen = false;
      });

  void _toggleSearch() => setState(() {
        _isSearching = !_isSearching;
        _isSearching ? _focusNode.requestFocus() : _focusNode.unfocus();
      });

  void _onMenuItemClicked(String menuItem) => setState(() {
        _selectedMenuItem = menuItem;
      });

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDarkTheme = themeNotifier.isDarkTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '#24527',
          style: TextStyle(fontFamily: 'Times New Roman'),
        ),
        leading: _isDrawerOpen
            ? IconButton(
                icon: const Icon(Icons.close, size: 20),
                onPressed: _closeDrawer,
              )
            : IconButton(
                icon: const Icon(Icons.article_outlined, size: 20),
                onPressed: _toggleDrawer,
              ),
        actions: [
          IconButton(
            icon: Icon(isDarkTheme ? Icons.brightness_7 : Icons.brightness_3),
            onPressed: () {
              themeNotifier.toggleTheme();
            },
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          if (_isDrawerOpen) _closeDrawer();
          if (_isSearching) _toggleSearch();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(isDarkTheme),
              const SizedBox(height: 20),
              _buildRegistrationForm(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(isDarkTheme),
    );
  }

  Widget _buildHeader(bool isDarkTheme) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(1.0),
        bottomRight: Radius.circular(90.0),
      ),
      child: Container(
        color: isDarkTheme ? Colors.black : const Color(0xFF317AF7),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 3.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (_isSearching)
                      Expanded(
                        child: TextField(
                          focusNode: _focusNode,
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          // Handle search text field changes
                        ),
                      ),
                    IconButton(
                      icon: const Icon(Icons.search),
                      iconSize: 20,
                      onPressed: _toggleSearch,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.only(left: 3.0),
                child: Text(
                  'Add a new book',
                  style: TextStyle(
                    color: isDarkTheme
                        ? Colors.white
                        : const Color.fromARGB(255, 223, 172, 4),
                    fontSize: 48,
                    fontFamily: 'Times New Roman',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

 Widget _buildRegistrationForm() {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 3,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _bookNameController,
            decoration: const InputDecoration(
              labelText: 'Book Name',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the book name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _authorController,
            decoration: const InputDecoration(
              labelText: 'Book Author',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the author\'s name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _pagesController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Number of Pages',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the number of pages';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _dateController,
            decoration: const InputDecoration(
              labelText: 'Date of Publish',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.datetime,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the date of publish';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _cityController,
            decoration: const InputDecoration(
              labelText: 'City of Publication',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the city of publication';
              }
              return null;
            },
          ),
          const SizedBox(height: 20.0),
          SizedBox(
            width: 200, // Adjust the width as needed
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  // Handle form submission
                  final bookName = _bookNameController.text;
                  final author = _authorController.text;
                  final pages = _pagesController.text;
                  final date = _dateController.text;
                  final city = _cityController.text;

                  // Implement your form submission logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Book Added: $bookName')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0), // Rectangle shape
                ), backgroundColor: Colors.deepOrange, // Button color
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    ),
  );
}


  Widget _buildBottomNavBar(bool isDarkTheme) {
    return BottomNavigationBar(
      backgroundColor: isDarkTheme ? Colors.black : Colors.white,
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: isDarkTheme ? Colors.white : Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notifications',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profile',
        ),
      ],
    );
  }
}
