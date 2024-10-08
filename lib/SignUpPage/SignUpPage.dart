import 'package:flutter/material.dart';
// Add this import for HTTP requests
import 'dart:convert'; // Import for JSON encoding/decoding




class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  int _currentStep = 0; // 0: Enter Details, 1: Verification, 2: Set Password
  String? email; // Variable to hold the email
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _goToNextStep(String email) {
    // Set the email and go to the next step
    setState(() {
      if (_currentStep < 2) {
        _currentStep++;
      }
    });
  }

  void _mailVerify(String email) {
    // Set the email and go to the next step
    setState(() {
      this.email = email; // Store the email for later use
      if (_currentStep < 2) {
        _currentStep++;
        _sendEmailInvite(email);
      }
    });
  }

  Future<void> _sendEmailInvite(String email) async {
    /* final url =
        Uri.parse('http://127.0.0.1:3030/mailQues');
    const _mail = {
      name: "onCodeVerifyEmail",
      type: "signup",
      from: "info@cloudbasha.com",
      recipients: [email],
      status: true,
      data: { name: name, code: loginEmailData.code },
      subject: "email code verification process",
      templateId: "onCodeVerify",
    }
    try {
      final response = await http.post(url);

      if (response.statusCode == 200) {
        // Email sent successfully
        print('Email invite sent successfully!');
      } else {
        // Handle error response
        print('Failed to send email invite: ${response.statusCode}');
      }
    } catch (error) {
      // Handle any errors that may occur
      print('Error sending email invite: $error');
    } */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: Colors.white,
        elevation: 0
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          _buildProgressIndicator(),
          const SizedBox(height: 20),
          Expanded(
            child: _buildStepContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStepIndicator('1', 'Enter details', _currentStep >= 0),
        _buildStepLine(),
        _buildStepIndicator('2', 'Verification', _currentStep >= 1),
        _buildStepLine(),
        _buildStepIndicator('3', 'Set up password', _currentStep >= 2),
      ],
    );
  }

  Widget _buildStepContent() {
    if (_currentStep == 0) {
      return EnterDetailsSection(
        contentHolder: _goToNextStep,
        onMailVerify: _mailVerify,
      );
    } else if (_currentStep == 1) {
      return VerifyEmailSection(contentHolder: _goToNextStep);
    } else {
      return SetUpPasswordSection();
    }
  }

  // Helper methods
  Widget _buildStepIndicator(String stepNumber, String label, bool isActive) {
    return Column(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: isActive ? Colors.red : Colors.grey.shade300,
          child: Text(
            stepNumber,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isActive ? Colors.black : Colors.grey.shade400,
          ),
        ),
      ],
    );
  }

  Widget _buildStepLine() {
    return Container(
      width: 50,
      height: 2,
      color: Colors.grey.shade300,
    );
  }

/*   Widget _detailsSection(){
    return  Column(
      children: [
        const Text(
          'Enter your details',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Full Name',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            String email = emailController.text.trim();
            if (email.isNotEmpty) {
              _mailVerify(email); // Pass the email to the next step
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Next',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
        const Spacer(),
        const Center(
          child: Text(
            '© 2024 CodeBridge Sdn Bhd. All rights reserved.',
            style: TextStyle(fontSize: 12, color: Colors.black45),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _verifyMailSection(){
    return Column(
      children: [
        const Text(
          'Verify your email',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Verification Code',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: contentHolder,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Next',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
        const Spacer(),
        const Center(
          child: Text(
            '© 2024 CodeBridge Sdn Bhd. All rights reserved.',
            style: TextStyle(fontSize: 12, color: Colors.black45),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _setPasswordSection(){
    return Column(
      children: [
        const Text(
          'Set up your password',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  suffixIcon: Icon(Icons.visibility),
                ),
              ),
              const SizedBox(height: 16),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm New Password',
                  suffixIcon: Icon(Icons.visibility),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Handle setting up account
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Set up my account',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        const Center(
          child: Text(
            '© 2024 CodeBridge Sdn Bhd. All rights reserved.',
            style: TextStyle(fontSize: 12, color: Colors.black45),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
   */
}

// First step: Enter details section
class EnterDetailsSection extends StatelessWidget {
  final Function(String) contentHolder;
  final Function(String) onMailVerify;

  const EnterDetailsSection(
      {Key? key, required this.contentHolder, required this.onMailVerify})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();

    return Column(
      children: [
        const Text(
          'Enter your details',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Full Name',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            String email = emailController.text.trim();
            if (email.isNotEmpty) {
              contentHolder(email);
              onMailVerify(email); // Pass the email to the next step
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Next',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
        const Spacer(),
        const Center(
          child: Text(
            '© 2024 CodeBridge Sdn Bhd. All rights reserved.',
            style: TextStyle(fontSize: 12, color: Colors.black45),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

// Second step: Verify email section
class VerifyEmailSection extends StatelessWidget {
  final Function(String) contentHolder;

  const VerifyEmailSection({Key? key, required this.contentHolder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Verify your email',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Verification Code',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Next',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
        const Spacer(),
        const Center(
          child: Text(
            '© 2024 CodeBridge Sdn Bhd. All rights reserved.',
            style: TextStyle(fontSize: 12, color: Colors.black45),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

// Third step: Set up password section
class SetUpPasswordSection extends StatelessWidget {
  const SetUpPasswordSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Set up your password',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  suffixIcon: Icon(Icons.visibility),
                ),
              ),
              const SizedBox(height: 16),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm New Password',
                  suffixIcon: Icon(Icons.visibility),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Handle setting up account
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Set up my account',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        const Center(
          child: Text(
            '© 2024 CodeBridge Sdn Bhd. All rights reserved.',
            style: TextStyle(fontSize: 12, color: Colors.black45),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
