import 'package:first_quiz/provider/BatteryService.dart';
import 'package:first_quiz/provider/ConnectivityService.dart';
import 'package:first_quiz/provider/cal_provider.dart';
import 'package:first_quiz/screens/adminPanel.dart';
import 'package:first_quiz/screens/dashboard_screen.dart';
import 'package:first_quiz/screens/home_screen.dart';
import 'package:first_quiz/screens/login.dart';
import 'package:first_quiz/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'theme_notifier.dart'; // import the ThemeNotifier

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
        ChangeNotifierProvider(create: (context) => ThemeNotifier()), // Add ThemeNotifier provider
      ],
      child: Consumer<ThemeNotifier>(
        builder: (context, theme, _) {
          return MaterialApp(
            theme: theme.isDarkTheme ? ThemeData.dark() : ThemeData.light(),
            debugShowCheckedModeBanner: false,
            home: const DashboardScreen(), // Set the DashboardScreen as the home screen
            routes: getAppRoutes(),
          );
        },
      ),
    );
  }

  Map<String, WidgetBuilder> getAppRoutes() {
    return {
      '/home': (context) => const HomeScreen(),
      '/signup': (context) => const Signup(),
        '/login': (context) => const Login(),
         '/dashboard_screen': (context) => const DashboardScreen(),
           '/adminPanel': (context) => const Adminpanel(),
    };
  }
}
