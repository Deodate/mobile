import 'package:first_quiz/contants/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    textEditingController.text = '0'; // Set initial value to '0'

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          border: InputBorder.none,
          fillColor: AppColors.secondaryColor,
          filled: true,
        ),
        style: const TextStyle(fontSize: 50),
        textAlign: TextAlign.right,
        readOnly: true,
        autofocus: true,
      ),
    );
  }
}
