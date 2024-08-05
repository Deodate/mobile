import 'package:first_quiz/contants/colors.dart';
import 'package:first_quiz/provider/cal_provider.dart';
import 'package:first_quiz/screens/widgets_data.dart';
import 'package:first_quiz/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/cal_button.dart';
import 'package:first_quiz/theme_notifier.dart'; // Import ThemeNotifier

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    const padding = EdgeInsets.symmetric(horizontal: 25, vertical: 30);
    const decoration = BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)));

    return Consumer2<CalculatorProvider, ThemeNotifier>(
        builder: (context, provider, themeNotifier, _) {
      return Scaffold(
        backgroundColor: themeNotifier.isDarkTheme
            ? Colors.black
            : AppColors.secondaryColor,
        appBar: AppBar(
          title: const Text("CALCULATOR"),
          backgroundColor: themeNotifier.isDarkTheme
              ? Colors.black
              : Colors.blue,
          actions: [
            IconButton(
              icon: Icon(themeNotifier.isDarkTheme
                  ? Icons.brightness_7
                  : Icons.brightness_3),
              onPressed: () {
                themeNotifier.toggleTheme();
              },
            ),
          ],
        ),
        body: Column(
          children: [
            CustomTextField(
              controller: provider.compController,
            ),
            const Spacer(),
            Container(
              height: screenHeight * 0.6,
              width: double.infinity,
              padding: padding,
              decoration: BoxDecoration(
                color: themeNotifier.isDarkTheme
                    ? Colors.grey[800]
                    : Colors.blue,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(4, (index) => buttonList[index]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(4, (index) => buttonList[index + 4]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(4, (index) => buttonList[index + 8]),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                  3, (index) => buttonList[index + 12]),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                  3, (index) => buttonList[index + 15]),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const CalculateButton()
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
