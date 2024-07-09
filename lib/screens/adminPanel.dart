import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_quiz/theme_notifier.dart';

class Adminpanel extends StatefulWidget {
  const Adminpanel({super.key});

  @override
  _AdminpanelState createState() => _AdminpanelState();
}

class _AdminpanelState extends State<Adminpanel> {
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
          'ADMIN PANEL',
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
                    color: isDarkTheme ? Colors.black : Color.fromARGB(255, 3, 65, 38),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'WELCOME BACK',
                            style: TextStyle(
                              color: isDarkTheme
                                  ? Colors.white
                                  : Color.fromARGB(255, 4, 4, 4),
                              fontSize: 38,
                              fontFamily: 'Times New Roman',
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
                  width: MediaQuery.of(context).size.width * 0.50,
                  height: MediaQuery.of(context).size.height *
                      0.84, // 84% of screen height
                  color: isDarkTheme
                      ? Colors.grey[900]
                      : Color.fromARGB(
                          255, 19, 58, 103), // Setting drawer background color
                  child: Column(
                    children: [
                      Container(
                        height: 65,
                        width: double.infinity, // Taking full width of drawer
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
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 65,
                color: isDarkTheme ? Colors.grey[800] : Color.fromARGB(255, 83, 87, 4),
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
                                icon: const Icon(Icons.account_balance,
                                    color: Color.fromARGB(255, 124, 241, 248),
                                    size: 30),
                                onPressed: () {
                                  // Handle home icon tap
                                  Navigator.pushNamed(
                                      context, '/dashboard_screen');
                                },
                              ),
                              // Text('Home'),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width *
                                0.28, // Adjust width for centering
                          ),
                          Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.list,
                                    color: Color.fromARGB(255, 25, 248, 36),
                                    size: 30),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/home');
                                },
                              ),
                              // Text('Calc'),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width *
                                0.13, // Adjust width for centering
                          ),
                          // Column(
                          //   children: [
                          //     IconButton(
                          //       icon: const Icon(Icons.list,
                          //           color: Color.fromARGB(255, 46, 237, 84),
                          //           size: 30),
                          //       onPressed: () {
                          //         Navigator.pushNamed(context, '/signup');
                          //       },
                          //     ),
                          //     // Text('Signup'),
                          //   ],
                          // ),
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
                              icon: const Icon(Icons.assignment_add,
                                  color: Color.fromARGB(255, 20, 49, 242),
                                  size: 30),
                              onPressed: () {
                                // Handle user icon tap
                                Navigator.pushNamed(context, '/login');
                              },
                            ),
                            // const Text('User'),
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
