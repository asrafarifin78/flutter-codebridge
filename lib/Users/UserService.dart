import 'package:http/http.dart' as http;
import '../constants.dart' as CONSTANT;
import './UserModel.dart';
import 'dart:convert';

// ignore: non_constant_identifier_names
Future<List<UserModel>> UserService(dynamic data) async {
  const path = "users";

  final responseObj = await http.get(
    Uri.parse('${CONSTANT.apiURL}$path'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (responseObj.statusCode == 200) {
    final jsonResponse = jsonDecode(responseObj.body);

    // Assuming the data is a list of user objects
    return (jsonResponse['data'] as List)
        .map((user) => UserModel.fromJson(user))
        .toList();
  } else {
    throw Exception('Failed to load user data');
  }
}
