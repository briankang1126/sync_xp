import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import '../models/users.dart';

class LoginController {
  final String filePath = 'lib/mock_data/mock_users.json';

  Future<List<User>> _loadUsers() async {
    final file = File(filePath);
    if (!await file.exists()) return [];
    final content = await file.readAsString();
    final List decoded = jsonDecode(content);
    return decoded.map((json) => User.fromJson(json)).toList();
  }

  Future<void> handleLogin({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      _showMessage(context, 'Please enter email and password');
      return;
    }
    final users = await _loadUsers();
    final user = users.firstWhere(
      (u) => u.email == email && u.password == password,
      orElse: () => User.empty(),
    );

    if (user.email.isNotEmpty) {
      _showMessage(context, 'Welcome back, ${user.username}!');
      // TODO: Navigate to next screen
    } else {
      _showMessage(context, 'Invalid credentials');
    }
  }

  void _showMessage(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
