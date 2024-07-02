import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class AppColors {
  static const Color primaryColor = Color(0xFF3b5999);
  static const Color textColor1 = Color(0xFF333333);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Registration Demo',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: AppColors.primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginSignupScreen(),
    );
  }
}

class LoginSignupScreen extends StatefulWidget {
  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController studentIDController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController testInputController = TextEditingController(); // Added controller for test input

  bool isSignupScreen = true;
  bool isRememberMe = false;
  bool firstNameError = false;
  bool lastNameError = false;
  bool studentIDError = false;

  @override
  void dispose() {
    // Clean up controllers
    firstNameController.dispose();
    lastNameController.dispose();
    studentIDController.dispose();
    passwordController.dispose();
    testInputController.dispose(); // Dispose the test input controller
    super.dispose();
  }

  Future<void> registerUser(String firstName, String lastName, String studentID, String password) async {
    final url = Uri.parse('http://localhost:3001/users');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'firstName': firstName,
          'lastName': lastName,
          'studentID': studentID,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User registered successfully')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to register user: ${response.statusCode}')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error registering user: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          Positioned(
            top: 5,
            right: 0,
            left: 0,
            child: Container(
              height: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("image/grad-skillss.webp"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                color: AppColors.primaryColor.withOpacity(.85),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context); // Navigate back on tap
                          },
                          child: Icon(Icons.arrow_back, color: Colors.white),
                        ),
                        SizedBox(width: 30), // Spacing for alignment
                        Text(
                          isSignupScreen ? "Signup to Continue.." : "Login to Continue..",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 255, 253, 253),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 80),
                    RichText(
                      text: TextSpan(
                        text: "Welcome to",
                        style: TextStyle(
                          fontSize: 28,
                          letterSpacing: 2,
                          color: Colors.yellow[700],
                        ),
                        children: [
                          TextSpan(
                            text: " AUCA ",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 200,
            child: SizedBox(height: 40),
          ),
          Positioned(
            top: 240,
            child: Container(
              height: 450,
              width: MediaQuery.of(context).size.width - 40,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSignupScreen = false;
                          });
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Column(
                            children: [
                              Text(
                                "LOGIN",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: !isSignupScreen
                                      ? AppColors.textColor1
                                      : AppColors.textColor1.withOpacity(0.5),
                                ),
                              ),
                              if (!isSignupScreen)
                                Container(
                                  height: 2,
                                  width: 55,
                                  color: Colors.orange,
                                ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSignupScreen = true;
                          });
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Column(
                            children: [
                              Text(
                                "REGISTER",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isSignupScreen
                                      ? AppColors.textColor1
                                      : AppColors.textColor1.withOpacity(0.5),
                                ),
                              ),
                              if (isSignupScreen)
                                Container(
                                  height: 2,
                                  width: 55,
                                  color: Colors.orange,
                                ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Toggle test section visibility
                          setState(() {
                            isSignupScreen = false; // Ensure signup screen is not selected
                          });
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Column(
                            children: [
                              Text(
                                "TEST",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isSignupScreen
                                      ? AppColors.textColor1
                                      : AppColors.textColor1.withOpacity(0.5),
                                ),
                              ),
                              if (isSignupScreen)
                                Container(
                                  height: 2,
                                  width: 55,
                                  color: Colors.orange,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (isSignupScreen)
                    buildSignupSection()
                  else if (!isSignupScreen) // Display the test section when the "test" variable is false
                    buildTestSection()
                  else
                    buildLoginSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLoginSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          TextField(
            controller: studentIDController,
            onChanged: (value) {
              setState(() {
                studentIDError = value.length != 5 || int.tryParse(value) == null;
              });
            },
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.account_circle),
              hintText: "Student ID e.g: 24527",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              errorText: studentIDError ? "Must be 5 numeric digits" : null,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            obscureText: true,
            controller: passwordController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
              hintText: "Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: isRememberMe,
                    onChanged: (value) {
                      setState(() {
                        isRememberMe = value!;
                      });
                    },
                  ),
                  Text(
                    "Remember Me",
                    style: TextStyle(
                      color: AppColors.textColor1,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  // Forgot password action
                },
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(color: Colors.orange),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Login action
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              "LOGIN",
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an account? "),
              TextButton(
                onPressed: () {
                  setState(() {
                    isSignupScreen = true;
                  });
                },
                child: Text(
                  "Register now",
                  style: TextStyle(color: Colors.orange),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSignupSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          TextField(
            controller: firstNameController,
            onChanged: (value) {
              setState(() {
                firstNameError = value.contains(RegExp(r'[0-9]'));
              });
            },
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.account_circle),
              hintText: "First Name e.g: Deodate",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              errorText: firstNameError ? "Cannot contain numbers" : null,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: lastNameController,
            onChanged: (value) {
              setState(() {
                lastNameError = value.contains(RegExp(r'[0-9]'));
              });
            },
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.account_circle),
              hintText: "Last Name e.g: Mugenzi",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              errorText: lastNameError ? "Cannot contain numbers" : null,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: studentIDController,
            onChanged: (value) {
              setState(() {
                studentIDError =
                    value.length != 5 || int.tryParse(value) == null;
              });
            },
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.account_circle),
              hintText: "* Student ID e.g: 24527",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              errorText: studentIDError ? "Must be 5 numeric digits" : null,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            obscureText: true,
            controller: passwordController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
              hintText: "Password e.g: ****************",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              if (firstNameController.text.isEmpty || lastNameController.text.isEmpty || studentIDController.text.isEmpty || passwordController.text.isEmpty) {
                // Show an error if any field is empty
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('All fields are required')));
                return;
              }

              // Call the registerUser function
              await registerUser(
                firstNameController.text,
                lastNameController.text,
                studentIDController.text,
                passwordController.text,
              );

              // Optionally navigate to the login screen or show a success message
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User registered successfully')));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              "REGISTER",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTestSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          TextField(
            controller: testInputController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.code),
              hintText: "Enter test data...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Handle test data submission
              String testData = testInputController.text;
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Test data submitted: $testData')));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              "SUBMIT TEST",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
