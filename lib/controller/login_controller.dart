import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import '../models/users.dart';
import 'package:collection/collection.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sync_xp/features/index.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginController {
  Future<File> _getUserFile() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/mock_users.json');

    if (!await file.exists()) {
      await file.create(recursive: true);
      await file.writeAsString('[]');
    }

    return file;
  }

  Future<List<User>> _loadUsers() async {
    final file = await _getUserFile();
    final content = await file.readAsString();
    final List decoded = jsonDecode(content);
    return decoded.map((e) => User.fromJson(e)).toList();
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
    final user = users.firstWhereOrNull(
      (u) => u.email == email && u.password == password,
    );

    if (user != null) {
    _showMessage(context, 'Welcome back, ${user.username}!');

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
        child: LoadingAnimationWidget.twoRotatingArc(
          color: Colors.tealAccent,
          size: 50,
        ),
      ),
    );

    await Future.delayed(const Duration(seconds: 4));

    if (context.mounted) {
      Navigator.pop(context); // Dismiss loading
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }

    } else {
      _showMessage(context, 'Invalid credentials');
    }
  }

  void _showMessage(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
