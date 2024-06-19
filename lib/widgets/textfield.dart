import 'package:first_quiz/contants/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
      child: TextField(
        // controller: TextEditController(),
        decoration: InputDecoration(
          border: InputBorder.none,
          fillColor: AppColors.secondaryColor,
          filled: true,
        ),
        style: const TextStyle(fontSize: 50),
        readOnly: true,
        autofocus: true,
        showCursor: true,
      ),
    );
  }
}
