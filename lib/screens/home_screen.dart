import 'package:first_quiz/contants/colors.dart';
import 'package:first_quiz/widgets/textfield.dart';
import 'package:first_quiz/widgets/button.dart'; // Import the Button1 widget
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final padding = const EdgeInsets.symmetric(horizontal: 25, vertical: 30);
    final decoration = BoxDecoration(
      color: AppColors.secondaryColor,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(23)),
    );

    return Scaffold(
      backgroundColor: const Color(0xFF4070F4), // Set Scaffold background color
      appBar: AppBar(
        title: const Text(
          "MOBILE",
          style: TextStyle(color: Colors.white), // Set text color to white
        ),
        backgroundColor: const Color(0xFF4070F4), // Set AppBar background color
      ),
      body: Column(
        children: [
          const CustomTextField(),
          Expanded(
            child: Container(
              padding: padding,
              decoration: decoration,
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: buttonList,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> get buttonList {
    return const [
      Button1(label: "1"),
      Button1(label: "2"),
      Button1(label: "3"),
      Button1(label: "4"),
      Button1(label: "5"),
      Button1(label: "6"),
      Button1(label: "7"),
      Button1(label: "8"),
      Button1(label: "9"),
      Button1(label: "0"),
    ];
  }
}
