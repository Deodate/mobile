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
  bool _isSearching = false; // State variable to track search input visibility
  final FocusNode _focusNode = FocusNode(); // FocusNode for the TextField
  final ScrollController _scrollController = ScrollController(); // ScrollController for ListView

  // State variable to track the selected menu item
  String _selectedMenuItem = 'All Books';

  void _toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  void _closeDrawer() {
    setState(() {
      _isDrawerOpen = false;
    });
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (_isSearching) {
        _focusNode.requestFocus(); // Request focus when search is activated
      } else {
        _focusNode.unfocus(); // Unfocus when search is deactivated
      }
    });
  }

  void _onMenuItemClicked(String menuItem) {
    setState(() {
      _selectedMenuItem = menuItem;
    });
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 500),
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
          style: TextStyle(
            fontFamily: 'Times New Roman',
          ),
        ),
        leading: _isDrawerOpen
            ? IconButton(
                icon: Icon(Icons.close, size: 20),
                onPressed: _closeDrawer,
              )
            : IconButton(
                icon: Icon(Icons.article_outlined, size: 20),
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
          if (_isDrawerOpen) {
            _closeDrawer();
          }
          if (_isSearching) {
            setState(() {
              _isSearching = false;
              _focusNode.unfocus(); // Unfocus when clicking outside
            });
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
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
                                  focusNode: _focusNode, // Assign the FocusNode
                                  decoration: InputDecoration(
                                    hintText: 'Search...',
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.symmetric(
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
                              icon: Icon(Icons.search),
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
                                : Color.fromARGB(255, 223, 172, 4),
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
                            TextButton(
                              onPressed: () => _onMenuItemClicked('All Books'),
                              child: Text(
                                'All Books',
                                style: TextStyle(
                                  color: _selectedMenuItem == 'All Books'
                                      ? Color.fromARGB(255, 223, 172, 4)
                                      : const Color.fromARGB(
                                          255, 249, 247, 247),
                                  fontSize: 17,
                                  fontFamily: 'Times New Roman',
                                  decoration: _selectedMenuItem == 'All Books'
                                      ? TextDecoration.underline
                                      : TextDecoration.none,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            TextButton(
                              onPressed: () => _onMenuItemClicked('NEW'),
                              child: Text(
                                'NEW',
                                style: TextStyle(
                                  color: _selectedMenuItem == 'NEW'
                                      ? Color.fromARGB(255, 223, 172, 4)
                                      : Colors.black,
                                  fontSize: 17,
                                  fontFamily: 'Times New Roman',
                                  decoration: _selectedMenuItem == 'NEW'
                                      ? TextDecoration.underline
                                      : TextDecoration.none,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            TextButton(
                              onPressed: () => _onMenuItemClicked('UPCOMING'),
                              child: Text(
                                'UPCOMING',
                                style: TextStyle(
                                  color: _selectedMenuItem == 'UPCOMING'
                                      ? Color.fromARGB(255, 223, 172, 4)
                                      : Colors.black,
                                  fontSize: 17,
                                  fontFamily: 'Times New Roman',
                                  decoration: _selectedMenuItem == 'UPCOMING'
                                      ? TextDecoration.underline
                                      : TextDecoration.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      color: Colors.white,
                      height: 320,
                      child: ListView.builder(
                        controller: _scrollController, // Attach ScrollController here
                        scrollDirection: Axis.horizontal,
                        itemCount: 4, // Replace with your actual list size
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: 270,
                            child: _buildBookCard(
                              'image/Flutter-App-development.jpg',
                              'Book Title ${index + 1}',
                              'Author Name ${index + 1}',
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10),

                   Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Authors to follow',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              TextButton(
                                onPressed: _scrollToBottom, // Scroll to bottom function
                                child: Text(
                                  'Show All',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),

                    // Row with cards
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 4,
                              child: Container(
                                height: 110,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.asset(
                                        'image/Flutter-App-development.jpg',
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Mr. Deodate', // Replace with your author name
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Maths', // Replace with your title
                                          style: TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 4,
                              child: Container(
                                height: 110,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.asset(
                                        'image/Flutter-App-development.jpg',
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Mr. Mugenzi', // Replace with your author name
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Physics', // Replace with your title
                                          style: TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
             Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Authors to follow',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              TextButton(
                                onPressed: _scrollToBottom, // Scroll to bottom function
                                child: Text(
                                  'Show All',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
            Container(
              height: 80,
              color: isDarkTheme ? Colors.grey[800] : Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildBottomNavItem(Icons.home, 'Home', '/dashboard_screen'),
                  _buildBottomNavItem(Icons.article_outlined, 'Exam', '/exam'),
                  _buildBottomNavItem(Icons.keyboard, 'Calc', '/home'),
                  _buildBottomNavItem(Icons.how_to_reg, 'Signup', '/signup'),
                  _buildBottomNavItem(Icons.person, 'User', '/adminPanel'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build a bottom navigation item
  Widget _buildBottomNavItem(IconData icon, String label, String route) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: Icon(icon, size: 30),
          color: _getBottomNavIconColor(label),
          onPressed: () {
            Navigator.pushNamed(context, route);
          },
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Text(label),
        ),
      ],
    );
  }

  // Function to get bottom navigation icon color based on the current route
  Color _getBottomNavIconColor(String label) {
    switch (label) {
      case 'Home':
        return Colors.black;
      case 'Exam':
        return Color.fromARGB(255, 249, 225, 40);
      case 'Calc':
        return Color.fromARGB(255, 121, 90, 90);
      case 'Signup':
        return Color.fromARGB(255, 46, 237, 84);
      case 'User':
        return Color.fromARGB(255, 250, 248, 248);
      default:
        return Colors.black;
    }
  }

  // Function to build a card for a book
  Widget _buildBookCard(String imagePath, String bookTitle, String authorName) {
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 150,
            height: 230,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  bookTitle,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  authorName,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
