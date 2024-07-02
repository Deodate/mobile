
import 'package:first_quiz/provider/BatteryService.dart';
import 'package:first_quiz/provider/ConnectivityService.dart';
import 'package:first_quiz/provider/cal_provider.dart';
import 'package:first_quiz/screens/dashboard_screen.dart';
import 'package:first_quiz/screens/home_screen.dart';
import 'package:first_quiz/screens/login_signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const CalculatorApp());
  ConnectivityService();
  BatteryService();
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CalculatorProvider()),
        // ChangeNotifierProvider(create: (context) => ConnectivityService()),
        // ChangeNotifierProvider(create: (context) => BatteryService()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.blue,
          scaffoldBackgroundColor:
              Colors.blue, // Set the scaffold background color to blue
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