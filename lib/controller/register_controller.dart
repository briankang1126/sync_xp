import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import '../models/users.dart';
import 'package:sync_xp/features/auth/login.dart';

class RegisterController {
  final String filePath = 'lib/mock_data/mock_users.json';

  Future<void> register(User user) async {
    final file = File(filePath);

    List<User> users = [];
    if (await file.exists()) {
      final content = await file.readAsString();
      if (content.trim().isNotEmpty) {
        final List decoded = jsonDecode(content);
        users = decoded.map((json) => User.fromJson(json)).toList();
      }
    } else {
      await file.create(recursive: true);
    }

    if (users.any((u) => u.email == user.email || u.username == user.username)) {
      throw Exception('User with this email or username already exists.');
    }

    users.add(user);
    final updatedContent = jsonEncode(users.map((u) => u.toJson()).toList());
    await file.writeAsString(updatedContent);
  }

  Future<void> handleRegister({
    required BuildContext context,
    required String fullName,
    required String username,
    required String email,
    required String password,
    required String confirm,
  }) async {
    if ([fullName, username, email, password, confirm].any((f) => f.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields.')),
      );
      return;
    }

    if (password != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match.')),
      );
      return;
    }

    try {
      final user = User(
        fullName: fullName,
        username: username,
        email: email,
        password: password,
      );
      await register(user);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration successful!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }
}

