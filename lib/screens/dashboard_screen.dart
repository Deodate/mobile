import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_quiz/theme_notifier.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isDrawerOpen = false;
  bool _isEnglish = true;

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

  void _toggleLanguage() {
    setState(() {
      _isEnglish = !_isEnglish;
    });
  }

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '#24527',
              style: TextStyle(
                fontFamily: 'Times New Roman',
                fontSize: 20,
              ),
            ),
            const SizedBox(width: 10), // Spacing between title and button
            TextButton(
              onPressed: _toggleLanguage,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: _isEnglish ? Colors.blue : Colors.red,
              ),
              child: Text(_isEnglish ? 'English' : 'Français'),
            ),
          ],
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
                          Text(
                            _isEnglish ? 'Mobile Class' : 'Classe Mobile',
                            style: TextStyle(
                              color: isDarkTheme
                                  ? Colors.white
                                  : Color.fromARGB(255, 223, 172, 4),
                              fontSize: 38,
                              fontFamily: 'Times New Roman',
                            ),
                          ),
                          const SizedBox(height: 10),
                          const CircleAvatar(
                            radius: 75,
                            backgroundImage:
                                AssetImage("image/Flutter-App-development.jpg"),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            _isEnglish
                                ? 'This is Assignment #Calculator & #SignUpLogin'
                                : "C'est le devoir #Calculator & #SignUpLogin",
                            style: TextStyle(
                              color: isDarkTheme
                                  ? Colors.white
                                  : const Color.fromARGB(255, 4, 4, 4),
                              fontSize: 17,
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
                      : const Color.fromARGB(
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
                            _isEnglish ? 'Primary' : 'Primaire',
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
                              text: _isEnglish ? 'Calculator' : 'Calculatrice',
                              fontSize: 20,
                              textColor: Colors.white,
                              onTap: () {
                                Navigator.pushNamed(context, '/home');
                                _closeDrawer();
                              },
                            ),
                            _buildListTile(
                              icon: Icons.email,
                              text: _isEnglish ? 'Login' : 'Connexion',
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
                              text: _isEnglish ? 'Register' : "S'inscrire",
                              fontSize: 20,
                              textColor: Colors.white,
                              iconColor: Colors.yellow,
                              onTap: () {
                                Navigator.pushNamed(context, '/signup');
                                _closeDrawer();
                              },
                            ),
                            _buildListTile(
                              icon: Icons.amp_stories_rounded,
                              text: _isEnglish ? 'Mind - Exam' : 'Esprit - Examen',
                              fontSize: 20,
                              textColor: Colors.white,
                              iconColor: Colors.blue,
                              onTap: () {
                                Navigator.pushNamed(context, '/exam');
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
                                    color: Color.fromARGB(255, 1, 1, 1),
                                    size: 30),
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, '/dashboard_screen');
                                },
                              ),
                              Text(_isEnglish ? 'Home' : 'Accueil'),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width *
                                0.12, // Adjust width for centering
                          ),
                           Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.article_outlined,
                                    color: Color.fromARGB(255, 249, 225, 40),
                                    size: 30),
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, '/dashboard_screen');
                                },
                              ),
                              Text(_isEnglish ? 'Exam' : 'Examen'),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width *
                                0.12, // Adjust width for centering
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
                              Text(_isEnglish ? 'Calc' : 'Calc'),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width *
                                0.10, // Adjust width for centering
                          ),
                          Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.how_to_reg,
                                    color: Color.fromARGB(255, 46, 237, 84),
                                    size: 30),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/signup');
                                },
                              ),
                              Text(_isEnglish ? 'Signup' : "S'inscrire"),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width *
                                0.20, // Adjust width for centering
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
                              icon: const Icon(Icons.person,
                                  color: Color.fromARGB(255, 250, 248, 248),
                                  size: 30),
                              onPressed: () {
                                Navigator.pushNamed(context, '/adminPanel');
                              },
                            ),
                            Text(_isEnglish ? 'User' : 'Utilisateur'),
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
        leading: Icon(icon, color: iconColor),
        title: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
