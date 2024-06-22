import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: const Color(0xFF317AF7), // Set the background color to the specified blue color
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/home');
                      },
                      child: const Text('Calculator'),
                    ),
                    const SizedBox(height: 20), // Space between buttons
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/login_signup');
                      },
                      child: const Text('Login & Signup'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 70, // Height of the footer
            color: Colors.blue, // Color of the footer
            child: Center(
              child: Text(
                'Deodate Mugenzi #24527',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
