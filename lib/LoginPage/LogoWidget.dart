import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'lib/images/codebridge_logo.png',
      width: 300.0, // Adjust width as needed
      height: 100.0, // Adjust height as needed
    );
  }
}