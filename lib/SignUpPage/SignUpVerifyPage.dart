import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignUpVerifyPage extends StatefulWidget {
  const SignUpVerifyPage({super.key});

  @override
  State<SignUpVerifyPage> createState() => _SignUpVerifyPageState();
}

class _SignUpVerifyPageState extends State<SignUpVerifyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: Colors.white,
        elevation: 0
      ),
      body: Column(),
    );
  }
}