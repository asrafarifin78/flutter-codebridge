import 'package:com_epi_test_flutter/DashboardPage/DashboardScreen.dart';
import 'package:com_epi_test_flutter/LoginPage/ForgotPasswordScreen.dart';
import 'package:com_epi_test_flutter/LoginPage/LoginPage.dart';
import 'package:com_epi_test_flutter/SignUpPage/SignUpPage.dart';
import 'package:com_epi_test_flutter/Users/UserWidget.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

String isLoggedIn = "0";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();
  isLoggedIn = localStorage.getItem('isLoggedIn') ?? '0';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: isLoggedIn == "0" ? const LoginPage() :  DashboardScreen(onThemeChanged: (bool value) {  },),
      routes: {
        '/forgot': (context) => const ForgotPasswordScreen(),
        '/login': (context) => const LoginPage(),
        '/dashboard': (context) => DashboardScreen(onThemeChanged: (bool value) {  },),
        '/setup' : (context) => const SignUpPage(),
        '/users' : (context) => const UserWidget()
      },
    );
  }
}
