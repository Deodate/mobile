import 'dart:async';

import 'package:first_quiz/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_quiz/theme_notifier.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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

  void _cancelTimer() {
    _timer?.cancel();
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

  final FocusNode _studentIdFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDarkTheme = themeNotifier.isDarkTheme;

    return Scaffold(
      appBar: AppBar(
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
            SingleChildScrollView(
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
                          'Login',
                          style: TextStyle(
                            fontFamily: 'Times New Roman',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: isDarkTheme ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildLabeledTextField('Email Address', 'Enter your email address', icon: Icons.person, focusNode: _studentIdFocusNode, isDarkTheme: isDarkTheme),
                        SizedBox(height: 20),
                        _buildLabeledTextField('Password', 'Enter your password', isPassword: true, icon: Icons.lock, focusNode: _passwordFocusNode, isDarkTheme: isDarkTheme),
                        SizedBox(height: 20),
                        SizedBox(
                          width: 150, // Adjust width as needed
                          child: ElevatedButton(
                            onPressed: () {
                              // Implement your login logic here
                              print('Login pressed');
                              _resetTimer(); // Reset timer when login button is pressed
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isDarkTheme ? Colors.white : Colors.black,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero, // Make the button rectangular
                              ),
                            ),
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                color: isDarkTheme ? Colors.black : Colors.white, // Set text color based on theme
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
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
                              // Navigate to registration page
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
                                color: _isHovering ? Colors.red : (isDarkTheme ? Colors.blue : Colors.black),
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
                  Container(
                    height: 65,
                    color: isDarkTheme ? Colors.grey[800] : Colors.blue,
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
                  color: isDarkTheme ? Colors.grey[900] : Color.fromARGB(255, 19, 58, 103),
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
              Positioned(
                bottom: 15,
                left: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
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
                                  icon: const Icon(Icons.home,
                                      color: Color.fromARGB(255, 250, 247, 247),
                                      size: 30),
                                  onPressed: () {
                                    // Handle home icon tap
                                    Navigator.pushNamed(
                                        context, '/dashboard_screen');
                                    _resetTimer(); // Reset timer when home icon is tapped
                                  },
                                ),
                                Text('Home'),
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width *
                                  0.28, // Adjust width for centering
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.keyboard,
                                      color: Color.fromARGB(255, 121, 90, 90),
                                      size: 30),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/home');
                                    _resetTimer(); // Reset timer when calculator icon is tapped
                                  },
                                ),
                                Text('Calc'),
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width *
                                  0.13, // Adjust width for centering
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.how_to_reg,
                                      color: Color.fromARGB(255, 46, 237, 84),
                                      size: 30),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/signup');
                                    _resetTimer(); // Reset timer when signup icon is tapped
                                  },
                                ),
                                Text('Signup'),
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width *
                                  0.28, // Adjust width for centering
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 15,
                        bottom: 0,
                        child: MouseRegion(
                          onEnter: (_) {
                            // Handle hover enter for User icon
                            print('Hover entered User');
                          },
                          onExit: (_) {
                            // Handle hover exit for User icon
                            print('Hover exited User');
                          },
                          child: Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.person,
                                    color: Color.fromARGB(255, 2, 1, 1),
                                    size: 40),
                                onPressed: () {
                                  // Handle user icon tap
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
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabeledTextField(String labelText, String hintText, {bool isPassword = false, IconData? icon, required FocusNode focusNode, required bool isDarkTheme}) {
    bool _obscureText = isPassword;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labelText),
          SizedBox(height: 5),
          Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                hintStyle: TextStyle(
                  color: isDarkTheme ? Colors.blue : Colors.grey, // Change hint text color based on theme
                ),
              ),
            ),
            child: TextField(
              focusNode: focusNode,
              obscureText: _obscureText,
              decoration: InputDecoration(
                hintText: hintText,
                border: OutlineInputBorder(),
                filled: true,
                fillColor: isDarkTheme ? Colors.grey[800] : Colors.white,
                prefixIcon: icon != null ? Icon(icon) : null,
                suffixIcon: isPassword
                    ? IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility : Icons.visibility_off,
                          color: isDarkTheme ? Colors.blue : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      )
                    : null,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              onTap: _resetTimer, // Reset timer when text field is tapped
              onChanged: (_) => _resetTimer(), // Reset timer when text field value changes
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile({required IconData icon, required String text, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: onTap,
    );
  }
}
