
import 'package:first_quiz/contants/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({super.key});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4070F4), // Set Scaffold background color
      appBar: AppBar(
        title: const Text(
          "Calculator App",
          style: TextStyle(color: Colors.white), // Set text color to white
        ),
        backgroundColor: const Color(0xFF4070F4), // Set AppBar background color
      ),
      body: const Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
            child: TextField(
              // controller: TextEditController(),
              decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: AppColors.secondaryColor, // Ensure this is defined
                filled: true,
              ),
              style: TextStyle(fontSize: 50),
              readOnly: true,
              autofocus: true,
              showCursor: true,
            ),
          ),
        ],
      ),
    );
  }
}

