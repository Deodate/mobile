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
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(
                    color: isDarkTheme ? Colors.black : const Color(0xFF317AF7),
                    child: Column(
                      children: [
                        SizedBox(height: 60), // Add some space at the top
                       
                        SizedBox(width: 8), // Adjust spacing as needed
                        Text(
                          'Login',
                          style: TextStyle(
                            fontFamily: 'Times New Roman',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20), // Add some space below the title
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildLabeledTextField('Student ID', 'Enter your student ID', icon: Icons.person, focusNode: _studentIdFocusNode, isDarkTheme: isDarkTheme),
                                SizedBox(height: 20),
                                _buildLabeledTextField('Password', 'Enter your password', isPassword: true, icon: Icons.lock, focusNode: _passwordFocusNode, isDarkTheme: isDarkTheme),
                                SizedBox(height: 20),
                                SizedBox(
                                  width: 150, // Adjust width as needed
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Implement your login logic here
                                      print('Login pressed');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: isDarkTheme ? Colors.white : Colors.black,
                                      shape: RoundedRectangleBorder(
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
                                SizedBox(height: 80),
                                GestureDetector(
                                  onTap: () {
                                    // Navigate to registration page
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Signup(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'If you have no account click here to register?',
                                    style: TextStyle(
                                      color: isDarkTheme ? Colors.blue : Colors.black,
                                      fontSize: 12,
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
                ),
                Container(
                  height: 65,
                  color: isDarkTheme ? Colors.grey[800] : Colors.blue,
                  child: Center(
                    child: Text(
                      'Deodate Mugenzi',
                      style: TextStyle(
                        color: isDarkTheme ? Colors.white : Colors.black,
                        fontSize: 15,
                        fontFamily: 'Times New Roman',
                      ),
                    ),
                  ),
                ),
              ],
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
                          child: Text(
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
                        },
                      ),
                      _buildListTile(
                        icon: Icons.email,
                        text: 'Login',
                        onTap: () {
                          Navigator.pushNamed(context, '/login');
                          _closeDrawer();
                        },
                      ),
                      _buildListTile(
                        icon: Icons.document_scanner,
                        text: 'Register',
                        onTap: () {
                          Navigator.pushNamed(context, '/signup');
                          _closeDrawer();
                        },
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
              obscureText: isPassword,
              decoration: InputDecoration(
                hintText: hintText,
                border: OutlineInputBorder(),
                filled: true,
                fillColor: isDarkTheme ? Colors.grey[800] : Colors.white,
                prefixIcon: icon != null ? Icon(icon) : null,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
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