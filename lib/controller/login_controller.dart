import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import '../models/users.dart';
import 'package:collection/collection.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sync_xp/features/index.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> _launchGame() async {
  final url = Uri.parse('https://dawnzours.itch.io/buddiefy');
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch game URL');
  }
}


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
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'images/character.png',
                width: 80,
                height: 80,
              ),
              const SizedBox(height: 20),
              LoadingAnimationWidget.twoRotatingArc(
                color: Colors.tealAccent,
                size: 50,
              ),
              const SizedBox(height: 16),
              AnimatedTextKit(
                totalRepeatCount: 1,
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Welcome to Buddiefy',
                    textStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: const Duration(milliseconds: 80),
                    cursor:'|',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );


    await Future.delayed(const Duration(seconds: 4));

    await _launchGame();
    
    } else {
      _showMessage(context, 'Invalid credentials');
    }
  }

  void _showMessage(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
