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
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(
                    color: isDarkTheme ? Colors.black : const Color(0xFF317AF7),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildTextField('Student ID'),
                          SizedBox(height: 20),
                          _buildTextField('Password', isPassword: true),
                          SizedBox(height: 20),
                          SizedBox(
                            width: 150, // Adjust width as needed
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    return isDarkTheme
                                        ? Colors.blue
                                        : Colors.black;
                                  },
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(
                                        color: Colors.transparent),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                // Implement your login logic here
                                // For example, authenticate user
                                print('Login pressed');
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
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
                                color: Colors.red,
                                fontSize: 12,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
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
                top: 2,
                left: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width *
                      0.50, // Adjust as needed
                  height: MediaQuery.of(context).size.height *
                      0.84, // Adjust as needed
                  color: isDarkTheme
                      ? Colors.grey[900]
                      : Color.fromARGB(255, 19, 58, 103),
                  child: Column(
                    children: [
                      Container(
                        height: 65,
                        width: double.infinity,
                        color: isDarkTheme ? Colors.grey[850] : Colors.blue,
                        child: DrawerHeader(
                          decoration: BoxDecoration(
                            color: isDarkTheme
                                ? Colors.grey[850]
                                : Colors.blue,
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
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            _buildListTile(
                              icon: Icons.keyboard,
                              text: 'Calculator',
                              fontSize: 20,
                              textColor: Colors.white,
                              onTap: () {
                                Navigator.pushNamed(context, '/home');
                                _closeDrawer();
                              },
                            ),
                            _buildListTile(
                              icon: Icons.email,
                              text: 'Login',
                              fontSize: 20,
                              textColor: Colors.white,
                              iconColor: Colors.red,
                              onTap: () {
                                Navigator.pushNamed(context, '/login');
                                _closeDrawer();
                              },
                            ),
                            _buildListTile(
                              icon: Icons.document_scanner,
                              text: 'Register',
                              fontSize: 20,
                              textColor: Colors.white,
                              iconColor: Colors.yellow,
                              onTap: () {
                                Navigator.pushNamed(context, '/signup');
                                _closeDrawer();
                              },
                            ),
                          ],
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

  Widget _buildTextField(String labelText, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    Color iconColor = Colors.black,
    Color textColor = Colors.black,
    double fontSize = 13,
  }) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        leading: Icon(icon, size: 20, color: iconColor),
        title: Text(
          text,
          style: TextStyle(
            fontFamily: 'Times New Roman',
            fontSize: fontSize,
            color: textColor,
          ),
        ),
        hoverColor: Colors.blue.withOpacity(0.5),
        onTap: onTap,
      ),
    );
  }
}
