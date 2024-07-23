import 'package:first_quiz/MID/add_book.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_quiz/theme_notifier.dart';


class ExamScreen extends StatefulWidget {
  const ExamScreen({Key? key}) : super(key: key);

  @override
  _ExamScreenState createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(isDarkTheme),
            _buildBookList(),
            // _buildAuthorsSection(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(isDarkTheme),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddBookScreen(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Add Book"),
        backgroundColor: const Color(0xFF317AF7),
      ),
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
                  'Discover books',
                  style: TextStyle(
                    color: isDarkTheme
                        ? Colors.white
                        : const Color.fromARGB(255, 223, 172, 4),
                    fontSize: 48,
                    fontFamily: 'Times New Roman',
                  ),
                ),
              ),
              const SizedBox(height: 7),
              Padding(
                padding: const EdgeInsets.only(left: 3.0),
                child: Row(
                  children: [
                    _buildMenuItem('All Books'),
                    const SizedBox(width: 10),
                    _buildMenuItem('NEW'),
                    const SizedBox(width: 10),
                    _buildMenuItem('UPCOMING'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(String menuItem) {
    return TextButton(
      onPressed: () => _onMenuItemClicked(menuItem),
      child: Text(
        menuItem,
        style: TextStyle(
          color: _selectedMenuItem == menuItem
              ? const Color.fromARGB(255, 223, 172, 4)
              : (Provider.of<ThemeNotifier>(context).isDarkTheme ? Colors.white : Colors.black),
          fontSize: 17,
          fontFamily: 'Times New Roman',
          decoration: _selectedMenuItem == menuItem
              ? TextDecoration.underline
              : TextDecoration.none,
        ),
      ),
    );
  }

  Widget _buildBookList() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.white,
              height: 300,
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 360,
                    child: _buildBookCard(
                      'image/Flutter-App-development.jpg',
                      'Book Title ${index + 1}',
                      'Author Name ${index + 1}',
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Authors to follow',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: _scrollToBottom,
                        child: const Text(
                          'Show All',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            _buildAuthorCards(),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthorCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildAuthorCard('image/Flutter-App-development.jpg', 'Mr. Deodate', 'Maths'),
          const SizedBox(width: 10),
          _buildAuthorCard('image/Flutter-App-development.jpg', 'Mr. Mugenzi', 'Physics'),
        ],
      ),
    );
  }

  Widget _buildAuthorCard(String imagePath, String authorName, String title) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        child: Container(
          height: 90,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imagePath,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    authorName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookCard(String imagePath, String title, String author) {
    return GestureDetector(
      onTap: () {
        // Handle book card tap
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        child: Container(
          width: 200,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imagePath,
                  width: 200,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                author,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar(bool isDarkTheme) {
    return BottomNavigationBar(
      backgroundColor: isDarkTheme ? Colors.black : Colors.white,
      selectedItemColor: isDarkTheme ? Colors.blueAccent : Colors.blue,
      unselectedItemColor: isDarkTheme ? Colors.grey : Colors.black54,
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
          icon: Icon(Icons.favorite),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profile',
        ),
      ],
      onTap: (index) {
        // Handle bottom navigation bar taps
      },
    );
  }
}
