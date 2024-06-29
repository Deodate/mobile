import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
                    color: const Color(0xFF317AF7),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Mobile Class',
                            style: TextStyle(
                              color: Color.fromARGB(255, 223, 172, 4),
                              fontSize: 38,
                              fontFamily: 'Times New Roman',
                            ),
                          ),
                          const SizedBox(height: 10),
                          CircleAvatar(
                            radius: 75, // Half of the height and width you want
                            backgroundImage: AssetImage("image/Flutter-App-development.jpg"),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            'This is Assignment #Calculator & #SignUpLogin',
                            style: TextStyle(
                              color: Color.fromARGB(255, 4, 4, 4),
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
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      'Deodate Mugenzi',
                      style: TextStyle(
                        color: Colors.black,
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
                  width: MediaQuery.of(context).size.width * 0.50,
                  height: MediaQuery.of(context).size.height * 0.84, // 84% of screen height
                  color: Color.fromARGB(255, 19, 58, 103), // Setting drawer background color to blue
                  child: Column(
                    children: [
                      Container(
                        height: 65,
                        width: double.infinity, // Taking full width of drawer
                        color: Colors.blue,
                        child: DrawerHeader(
                          decoration: BoxDecoration(
                            color: Colors.blue,
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
                              textColor: Colors.white, // Setting text color to white
                              onTap: () {
                                Navigator.pushNamed(context, '/home');
                                _closeDrawer();
                              },
                            ),
                            _buildListTile(
                              icon: Icons.email,
                              text: 'Login',
                               fontSize: 20,
                              textColor: Colors.white, // Setting text color to white
                              iconColor: Colors.red, // Changing email icon color to red
                              onTap: () {
                                Navigator.pushNamed(context, '/login_signup');
                                _closeDrawer();
                              },
                            ),
                             _buildListTile(
                              icon: Icons.document_scanner,
                              text: 'Register',
                               fontSize: 20,
                              textColor: Colors.white, // Setting text color to white
                              iconColor: Colors.yellow, // Changing icon color to yellow
                              onTap: () {
                                Navigator.pushNamed(context, '/login_signup');
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

  Widget _buildListTile({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    Color iconColor = Colors.black, // Default icon color is black
    Color textColor = Colors.black, // Default text color is black
    double fontSize = 13, // Default font size
  }) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        leading: Icon(icon, size: 20, color: iconColor), // Applying iconColor to icon
        title: Text(
          text,
          style: TextStyle(
            fontFamily: 'Times New Roman',
            fontSize: fontSize,
            color: textColor, // Applying textColor to text
          ),
        ),
        hoverColor: Colors.blue.withOpacity(0.5),
        onTap: onTap,
      ),
    );
  }
}
