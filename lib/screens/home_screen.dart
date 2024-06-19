import 'package:first_quiz/contants/colors.dart';
import 'package:first_quiz/screens/widgets_data.dart';
import 'package:first_quiz/widgets/textfield.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
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
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.0,
                ),
                itemCount: buttonList.length + 1, // Add an extra item for the large button
                itemBuilder: (context, index) {
                  if (index == buttonList.length) {
                    // The last item should span two columns
                    return SizedBox(
                      width: double.infinity, // Expand to full width
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        // child: Button1(
                          // label: "=",
                          // backgroundColor: Colors.black,
                          // textColor: Colors.white,
                        // ),
                      ),
                    );
                  }
                  return buttonList[index];
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
