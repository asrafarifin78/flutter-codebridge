import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String userName;

  const UserCard({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        height: 100,
        child: Center(
          child: Text(
            userName,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
