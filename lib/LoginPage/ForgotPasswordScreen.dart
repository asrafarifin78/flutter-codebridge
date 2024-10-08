import 'package:flutter/material.dart';


// Updated ForgotPasswordScreen StatefulWidget and its State
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ForgotPasswordScreenState createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool emailSent = false; // State variable to manage if the email is sent

  void sendResetEmail() {
    setState(() {
      emailSent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size to adjust padding for mobile view
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          // Adjust padding for mobile view
          padding: EdgeInsets.all(isMobile ? 16.0 : 20.0),
          child: emailSent
              ? _buildEmailSentScreen(isMobile)
              : _buildForgotPasswordScreen(isMobile),
        ),
      ),
    );
  }

  // First Screen - Forgot Password
  Widget _buildForgotPasswordScreen(bool isMobile) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // Logo
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              // Replace Icon with Image
              Image.asset(
                'lib/images/codebridge_logo.png',
                width: isMobile ? 200 : 300, // Adjust size for mobile
              ),
            ],
          ),
        ),
        // "Forgot your password?" Text
        Text(
          'Forgot your password?',
          style: TextStyle(
            fontSize: isMobile ? 20 : 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        // Description Text
        Text(
          'Please enter your registered email and we’ll send you instructions to reset your password.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isMobile ? 14 : 16,
          ),
        ),
        const SizedBox(height: 20),
        // Email TextField
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            labelText: 'Email',
            hintText: 'Enter your registered email',
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),
        // "Send reset instructions" Button
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: sendResetEmail,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 233, 34, 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Send reset instructions',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        // "Back to login" TextButton
        TextButton(
          onPressed: () {
            // Add navigation to login screen here
          },
          child: const Text(
            'Back to login',
            style: TextStyle(
              color: Color.fromARGB(255, 228, 27, 13),
            ),
          ),
        ),
      ],
    );
  }

  // Second Screen - Email Sent Confirmation
  Widget _buildEmailSentScreen(bool isMobile) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // Email Sent Image
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Image.asset(
                'lib/images/email_sent.png', // Placeholder image
                width: isMobile ? 200 : 300, // Adjust size for mobile
              ),
            ],
          ),
        ),
        // "Check your email" Text
        Text(
          'Check your email',
          style: TextStyle(
            fontSize: isMobile ? 20 : 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        // Description Text
        Text(
          'We’ve sent you an email with instructions to reset your password. '
          'Check your Junk/Spam folder if it doesn’t arrive.'
          'If you still cant login, click resend email or contact your administrator.'
          ,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isMobile ? 14 : 16,
          ),
        ),
        const SizedBox(height: 20),
        // Resend email Button
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              // Logic to resend email
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Successfully resent email. Please check your inbox or Junk/Spam folder.',
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 228, 35, 21),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Resend email',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        // "Back to login" TextButton
        TextButton(
          onPressed: () {
            // Add navigation to login screen here
          },
          child: const Text(
            'Back to login',
            style: TextStyle(
              color: Color.fromARGB(255, 190, 28, 17),
            ),
          ),
        ),
      ],
    );
  }
}
