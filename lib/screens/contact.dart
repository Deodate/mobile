import 'dart:async';
import 'package:first_quiz/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_quiz/theme_notifier.dart';

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  bool _isDrawerOpen = false;
  bool _isHovering = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer(const Duration(seconds: 10), () {
      Navigator.pushNamedAndRemoveUntil(context, '/dashboard_screen', (route) => false);
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    _startTimer();
  }

  void _toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
    _resetTimer(); // Reset timer when drawer is toggled
  }

  void _closeDrawer() {
    setState(() {
      _isDrawerOpen = false;
    });
    _resetTimer(); // Reset timer when drawer is closed
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDarkTheme = themeNotifier.isDarkTheme;

    return Scaffold(
      appBar: AppBar(
        leading: _isDrawerOpen
            ? IconButton(
                icon: const Icon(Icons.close, size: 20),
                onPressed: _closeDrawer,
              )
            : IconButton(
                icon: const Icon(Icons.menu, size: 20),
                onPressed: _toggleDrawer,
              ),
        actions: [
          IconButton(
            icon: Icon(isDarkTheme ? Icons.brightness_7 : Icons.brightness_3),
            onPressed: () {
              themeNotifier.toggleTheme();
              _resetTimer(); // Reset timer when theme is toggled
            },
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          if (_isDrawerOpen) {
            _closeDrawer();
          }
          _resetTimer(); // Reset timer when tapping outside
        },
        child: Stack(
          children: [
            // Expanded to take up remaining space
            Positioned.fill(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            color: isDarkTheme ? Colors.black : const Color(0xFF317AF7),
                            padding: EdgeInsets.symmetric(vertical: 60, horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'MY CONTACT',
                                  style: TextStyle(
                                    fontFamily: 'Times New Roman',
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: isDarkTheme ? Colors.white : Colors.black,
                                  ),
                                ),
                                MouseRegion(
                                  onEnter: (_) {
                                    setState(() {
                                      _isHovering = true;
                                    });
                                  },
                                  onExit: (_) {
                                    setState(() {
                                      _isHovering = false;
                                    });
                                  },
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const Signup(),
                                        ),
                                      );
                                      _resetTimer(); // Reset timer when signup link is tapped
                                    },
                                    child: AnimatedDefaultTextStyle(
                                      duration: const Duration(milliseconds: 300),
                                      style: TextStyle(
                                        color: _isHovering
                                            ? Colors.red
                                            : (isDarkTheme
                                                ? Colors.blue
                                                : Colors.black),
                                        fontSize: 15,
                                      ),
                                      child: const Text(
                                        'If you have no account click here to register?',
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 238),
                              ],
                            ),
                          ),
                          // Other widgets can go here
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (_isDrawerOpen)
              GestureDetector(
                onTap: _closeDrawer,
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            if (_isDrawerOpen)
              Positioned(
                top: 0,
                left: 0,
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  color: isDarkTheme
                      ? Colors.grey[900]
                      : Color.fromARGB(255, 19, 58, 103),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 65,
                        width: double.infinity,
                        color: isDarkTheme ? Colors.grey[850] : Colors.blue,
                        child: DrawerHeader(
                          decoration: BoxDecoration(
                            color: isDarkTheme ? Colors.grey[850] : Colors.blue,
                          ),
                          child: const Text(
                            'Primary',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontFamily: 'Times New Roman',
                            ),
                          ),
                        ),
                      ),
                      _buildListTile(
                        icon: Icons.keyboard,
                        text: 'Calculator',
                        onTap: () {
                          Navigator.pushNamed(context, '/home');
                          _closeDrawer();
                          _resetTimer(); // Reset timer when navigating to home
                        },
                      ),
                      _buildListTile(
                        icon: Icons.email,
                        text: 'Login',
                        onTap: () {
                          Navigator.pushNamed(context, '/login');
                          _closeDrawer();
                          _resetTimer(); // Reset timer when navigating to login
                        },
                      ),
                      _buildListTile(
                        icon: Icons.document_scanner,
                        text: 'Register',
                        onTap: () {
                          Navigator.pushNamed(context, '/signup');
                          _closeDrawer();
                          _resetTimer(); // Reset timer when navigating to signup
                        },
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 65,
        color: isDarkTheme ? Colors.grey[800] : Colors.blue,
        child: Stack(
          children: [
            Positioned(
              left: 16,
              bottom: 0,
              child: Row(
                children: [
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.home,
                          color: Color.fromARGB(255, 250, 247, 247),
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/dashboard_screen');
                          _resetTimer(); // Reset timer when home icon is tapped
                        },
                      ),
                      Text('Home'),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.28, // Adjust width for centering
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.keyboard,
                          color: Color.fromARGB(255, 121, 90, 90),
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/home');
                          _resetTimer(); // Reset timer when calculator icon is tapped
                        },
                      ),
                      Text('Calc'),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.13, // Adjust width for centering
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.how_to_reg,
                          color: Color.fromARGB(255, 46, 237, 84),
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                          _resetTimer(); // Reset timer when signup icon is tapped
                        },
                      ),
                      Text('Signup'),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.28, // Adjust width for centering
                  ),
                ],
              ),
            ),
            Positioned(
              right: 15,
              bottom: 0,
              child: MouseRegion(
                onEnter: (_) {
                  print('Hover entered User');
                },
                onExit: (_) {
                  print('Hover exited User');
                },
                child: Column(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.person,
                        color: Color.fromARGB(255, 2, 1, 1),
                        size: 40,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                        _resetTimer(); // Reset timer when user icon is tapped
                      },
                    ),
                    const Text('User'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile({required IconData icon, required String text, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(text, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }
}
