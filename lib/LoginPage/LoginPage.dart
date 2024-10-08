import 'package:com_epi_test_flutter/LoginPage/LogoWidget.dart';
import 'package:com_epi_test_flutter/DashboardPage/DashboardScreen.dart';
import 'package:com_epi_test_flutter/LoginPage/ForgotPasswordScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:localstorage/localstorage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isRememberMeChecked = false; // For the "Remember me" checkbox
  bool _isLoading = false;

  // Create an instance of LocalStorage

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      // Perform login logic here, e.g., API call or Firebase Auth.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All fields are required ...')),
      );

// temp
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DashboardScreen(
                onThemeChanged: (bool value) {},
              )));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Replace with your actual API URL
    const String apiUrl = "http://localhost:3030/authentication";

    try {
      final responseObj = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': _emailController.text,
          'password': _passwordController.text,
          'strategy': 'local'
        }),
      );

      final Map<String, dynamic> response = jsonDecode(responseObj.body);

      if (kDebugMode) {
        print(responseObj.statusCode);
        // print(responseObj.body);
        // print(_emailController.text);
        // print(_passwordController.text);
      }

      if (responseObj.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful')),
        );
        localStorage.setItem("isLoggedIn", "1");
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DashboardScreen(
                  onThemeChanged: (bool value) {},
                )));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'] ?? 'Login failed')),
        );
        // Handle server errors
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Server error, try again later, ${jsonEncode(error)}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _setupAccount() {
    // Navigate to the setup account page or perform any action here
    Navigator.pushNamed(context, "/setup");
  }

  void _forgotPassword() {
    // Navigate to forgot password page or perform any action here
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(content: Text('Navigate to forgot password page.')),
    // );

    Navigator.pushNamed(context, "/forgot");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Header icon
                const LogoWidget(),
                const SizedBox(height: 4), // Spacing below the icon

                // Login form
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Email label and input field
                      const Text(
                        'Email',
                        style: TextStyle(fontSize: 12.0),
                      ),
                      const SizedBox(
                          height: 8), // Spacing between label and input
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'Enter your registered email',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                          height: 16), // Spacing between input fields

                      // Password label and input field
                      const Text(
                        'Password',
                        style: TextStyle(fontSize: 12.0),
                      ),
                      const SizedBox(
                          height: 8), // Spacing between label and input
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                      ),

                      // Checkbox and Forgot Password Row
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Remember me checkbox
                          Row(
                            children: [
                              Checkbox(
                                value: _isRememberMeChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isRememberMeChecked = value ?? false;
                                  });
                                },
                              ),
                              const Text('Remember me'),
                            ],
                          ),
                          // Forgot password hyperlink
                          ElevatedButton(
                            onPressed: () {
                              final snackBar = SnackBar(
                                content: const Text(
                                    'Navigate to forgot password page.'),
                                action: SnackBarAction(
                                  label: 'Undo',
                                  onPressed: () {
                                    // Some code to undo the change.
                                  },
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordScreen()));
                            },
                            child: const Text(
                              'Forgot ?',
                              style: TextStyle(
                                color: Colors.red,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                          height: 32), // Spacing between input fields

                      // Sign In button
                      ElevatedButton(
                        onPressed: () {
                          if (kDebugMode) {
                            print("clicked login");
                          }
                          _login();
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                            const Color.fromARGB(255, 199, 6, 6),
                          ), // Set the correct color
                          foregroundColor: WidgetStateProperty.all<Color>(
                            const Color.fromARGB(255, 251, 250, 250),
                          ),
                        ),
                        child: const Text('Sign In'),
                      ),

                      const SizedBox(height: 8), // Spacing

                      // Text with grey underline
                      Column(
                        children: [
                          const SizedBox(height: 4), // Space below underline
                          RichText(
                            text: TextSpan(
                              text: "Haven't activated your account yet? ",
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 12),
                              children: [
                                TextSpan(
                                  text: 'Set up now',
                                  style: const TextStyle(
                                    color: Colors.red,
                                    decoration: TextDecoration.none,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap =
                                        _setupAccount, // Handle hyperlink tap
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      // Additional hyperlinks below the grey underline
                      const SizedBox(height: 32), // Space between
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Handle "Can't log in" tap
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Can't log in.")),
                              );
                            },
                            child: const Text(
                              "Can't log in?",
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.bold,
                                fontSize: 11.0,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Handle "Sign in with custom domain" tap
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Sign in with custom domain.')),
                              );
                            },
                            child: const Text(
                              'Sign in with custom domain',
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.bold,
                                fontSize: 11.0,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                          height: 64), // Spacing between input fields

                      const Center(
                        child: Text(
                          '© 2024 CodeBridge Sdn Bhd. All rights reserved.',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
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
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: LoginPage(),
  ));
}
