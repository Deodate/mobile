import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_quiz/theme_notifier.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _isDrawerOpen = false;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController facultyController = TextEditingController();
  TextEditingController studentIdsController = TextEditingController();
  TextEditingController passwordsController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool passwordsMatch = true; // Initialize with a default value

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

  final FocusNode _studentIdsFocusNode = FocusNode();
  final FocusNode _fullNameFocusNode = FocusNode();
  final FocusNode _facultyFocusNode = FocusNode();
  final FocusNode _passwordsFocusNode = FocusNode();
  final FocusNode _cPasswordFocusNode = FocusNode();

  void _checkPasswordMatch() {
    // Check if passwords match
    if (passwordsController.text != confirmPasswordController.text) {
      setState(() {
        passwordsMatch = false;
      });
    } else {
      setState(() {
        passwordsMatch = true;
      });
    }
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
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: isDarkTheme ? Colors.black : const Color(0xFF317AF7),
                    padding:
                        const EdgeInsets.symmetric(vertical: 60, horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Create Account',
                          style: TextStyle(
                            fontFamily: 'Times New Roman',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: isDarkTheme ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 15),
                        _buildLabeledTextField(
                          '* Full Name',
                          'Enter your names',
                          icon: Icons.person,
                          focusNode: _fullNameFocusNode,
                          isDarkTheme: isDarkTheme,
                          controller: fullNameController,
                        ),
                        const SizedBox(height: 2),
                        _buildLabeledTextField(
                          '* Faculty',
                          'Enter your faculty',
                          icon: Icons.person,
                          focusNode: _facultyFocusNode,
                          isDarkTheme: isDarkTheme,
                          controller: facultyController,
                        ),
                        const SizedBox(height: 2),
                        _buildLabeledTextField(
                          '* Email Address',
                          'Enter your email',
                          icon: Icons.person,
                          focusNode: _studentIdsFocusNode,
                          isDarkTheme: isDarkTheme,
                          controller: studentIdsController,
                        ),
                        const SizedBox(height: 2),
                        _buildLabeledTextField(
                          '* Password',
                          'Enter your password',
                          isPassword: true,
                          icon: Icons.lock,
                          focusNode: _passwordsFocusNode,
                          isDarkTheme: isDarkTheme,
                          controller: passwordsController,
                        ),
                        const SizedBox(height: 2),
                        _buildLabeledTextField(
                          '* Confirm Password',
                          'Confirm your password',
                          isPassword: true,
                          icon: Icons.lock,
                          focusNode: _cPasswordFocusNode,
                          isDarkTheme: isDarkTheme,
                          controller: confirmPasswordController,
                          passwordsMatch: passwordsMatch,
                          borderColor: passwordsMatch
                              ? null
                              : Colors.red, // Dynamic border color
                        ),
                        const SizedBox(height: 2),
                        SizedBox(
                          width: 150, // Adjust width as needed
                          child: ElevatedButton(
                            onPressed: () {
                              _checkPasswordMatch(); // Check passwords on button press
                              // Implement your registration logic here
                              print('Register pressed');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  isDarkTheme ? Colors.white : Colors.black,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius
                                    .zero, // Make the button rectangular
                              ),
                            ),
                            child: Text(
                              'REGISTER',
                              style: TextStyle(
                                color: isDarkTheme
                                    ? Colors.black
                                    : Colors
                                        .white, // Set text color based on theme
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        MouseRegion(
                          onEnter: (_) {},
                          onExit: (_) {},
                          child: GestureDetector(
                            onTap: () {
                              // Navigate to registration page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Signup(),
                                ),
                              );
                            },
                            child: const AnimatedDefaultTextStyle(
                              duration: Duration(milliseconds: 300),
                              style: TextStyle(
                                // color: _isHovering ? Colors.red : (isDarkTheme ? Colors.blue : Colors.black),
                                fontSize: 15,
                              ),
                              child: Text(
                                'If you ve an account click here to Signin?',
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
                                    color: Color.fromARGB(255, 251, 249, 249),
                                    size: 30),
                                onPressed: () {
                                  // Handle home icon tap
                                  Navigator.pushNamed(
                                      context, '/dashboard_screen');
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
                                    color: Color.fromARGB(255, 3, 3, 3),
                                    size: 30),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/signup');
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
                                  color: Color.fromARGB(255, 250, 248, 248),
                                  size: 30),
                              onPressed: () {
                                // Handle user icon tap
                                Navigator.pushNamed(context, '/login');
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

  @override
  void dispose() {
    fullNameController.dispose();
    facultyController.dispose();
    studentIdsController.dispose();
    passwordsController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Widget _buildListTile(
      {required IconData icon,
      required String text,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: onTap,
    );
  }

  Widget _buildLabeledTextField(
    String labelText,
    String hintText, {
    bool isPassword = false,
    IconData? icon,
    required FocusNode focusNode,
    required bool isDarkTheme,
    required TextEditingController controller,
    bool passwordsMatch = true,
    MaterialColor? borderColor,
  }) {
    bool _obscureText = isPassword;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labelText),
          const SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200], // Set gray background color
              borderRadius: BorderRadius.circular(8),
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                inputDecorationTheme: InputDecorationTheme(
                  hintStyle: TextStyle(
                    color: isDarkTheme ? Colors.blue : Colors.grey,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: borderColor ?? Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: borderColor ?? Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: borderColor ?? Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                obscureText: _obscureText,
                onChanged: (value) {
                  if (isPassword) {
                    _checkPasswordMatch();
                  }
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 15),
                  hintText: hintText,
                  prefixIcon: icon != null ? Icon(icon) : null,
                  suffixIcon: isPassword
                      ? IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
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
                    borderSide: BorderSide(
                      color: borderColor ?? Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: borderColor ?? Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: borderColor ?? Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
