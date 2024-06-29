
import 'package:first_quiz/provider/cal_provider.dart';
import 'package:first_quiz/screens/dashboard_screen.dart';
import 'package:first_quiz/screens/home_screen.dart';
import 'package:first_quiz/screens/login_signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CalculatorProvider(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.blue,
          scaffoldBackgroundColor: Colors.blue, // Set the scaffold background color to blue
          appBarTheme: const AppBarTheme(
            color: Colors.blue, // Set the app bar color to blue
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Set the button color to blue
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const DashboardScreen(), // Set the DashboardScreen as the home screen
        routes: getAppRoutes(),
      ),
    );
  }

  Map<String, WidgetBuilder> getAppRoutes() {
    return {
      '/home': (context) => const HomeScreen(),
      '/login_signup': (context) => LoginSignupScreen(),
    };
  }
}
