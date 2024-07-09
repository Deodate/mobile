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
    });
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
                icon: Icon(Icons.menu, size: 20),
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
                          children: [
                            IconButton(
                              icon: Icon(Icons.search),
                              iconSize: 20,
                              onPressed: () {
                                // Handle left search icon press
                              },
                            ),
                            SizedBox(width: 2),
                            IconButton(
                              icon: Icon(Icons.search),
                              iconSize: 20,
                              onPressed: () {
                                // Handle right search icon press
                                _toggleSearch();
                              },
                            ),
                            SizedBox(width: 2),
                            if (_isSearching)
                              Expanded(
                                child: TextField(
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
                      const SizedBox(height: 14),
                      Padding(
                        padding: const EdgeInsets.only(left: 3.0),
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                // Handle action
                              },
                              child: Text(
                                'CLASSICS',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontFamily: 'Times New Roman',
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            TextButton(
                              onPressed: () {
                                // Handle action
                              },
                              child: Text(
                                'NEW',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontFamily: 'Times New Roman',
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            TextButton(
                              onPressed: () {
                                // Handle action
                              },
                              child: Text(
                                'UPCOMING',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontFamily: 'Times New Roman',
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
              child: Container(
                color: Colors.white,
                child: Center(
                  child: Text(
                    'Your main content here',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            Container(
              height: 65,
              color: isDarkTheme ? Colors.grey[800] : Colors.blue,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 65,
        color: isDarkTheme ? Colors.grey[800] : Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                Navigator.pushNamed(context, '/dashboard_screen');
              },
            ),
            IconButton(
              icon: const Icon(Icons.amp_stories),
              onPressed: () {
                Navigator.pushNamed(context, '/exam');
              },
            ),
            IconButton(
              icon: const Icon(Icons.keyboard),
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
            IconButton(
              icon: const Icon(Icons.how_to_reg),
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
            ),
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                Navigator.pushNamed(context, '/adminPanel');
              },
            ),
          ],
        ),
      ),
    );
  }
}
