import 'dart:convert';
import 'package:com_epi_test_flutter/Users/UserCard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './UserService.dart'; // Import the UserService
import './UserModel.dart'; // Import the UserModel

class UserWidget extends StatefulWidget {
  const UserWidget({super.key});

  @override
  State<UserWidget> createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  List<UserModel> users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      // Fetch the user data
      final List<UserModel> response = await UserService(jsonEncode({'someParam': 'value'}));

      setState(() {
        users = response;
        isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching user data: $e");
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('User Information'),
      backgroundColor: Colors.white,
      elevation: 0,
    ),
    body: isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              // Provide a fallback value for null names
              return UserCard(userName: users[index].name ?? "Unknown");
            },
          ),
  );
}

}
