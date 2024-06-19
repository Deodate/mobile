import 'package:first_quiz/contants/colors.dart';
import 'package:flutter/material.dart';

class Button1 extends StatelessWidget {
  const Button1({
    super.key,
    required this.label,
    this.textColor = Colors.white,
  });

  final String label;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(50),
      child: CircleAvatar(
        radius: 36,
        backgroundColor: AppColors.secondaryColor,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
