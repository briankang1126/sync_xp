import 'package:flutter/material.dart';
import 'package:sync_xp/auth/login.dart';
import 'package:sync_xp/auth/register.dart';

void main() => runApp(const SyncXPApp());

class SyncXPApp extends StatelessWidget {
  const SyncXPApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const WelcomeScreen(),
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

const String kBgImg = 'https://i.imgur.com/qMvzsmi.jpeg';

/// 1. Welcome Screen
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image and overlay
          Positioned.fill(
            child: Image.network(kBgImg, fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.6)),
          ),
          // Main content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 56),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.music_note, color: Colors.tealAccent, size: 56),
                  const SizedBox(height: 36),
                  Text(
                    "Let's Get Started!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: Colors.tealAccent,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 48),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.tealAccent.shade700,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: const Text("SIGN IN", style: TextStyle(fontSize: 18)),
                    ),
                  ),
                  const SizedBox(height: 26),
                  Text(
                    "or sign in with",
                    style: TextStyle(color: Colors.white70, fontSize: 15),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.tealAccent.shade700,
                        child: Icon(Icons.email, color: Colors.black),
                      ),
                      const SizedBox(width: 20),
                      CircleAvatar(
                        backgroundColor: Colors.tealAccent.shade700,
                        child: Icon(Icons.phone_android, color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 36),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Didn't have account?",
                        style: TextStyle(color: Colors.white70, fontSize: 15),
                      ),
                      TextButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const RegisterScreen()),
                        ),
                        child: const Text("SIGN UP NOW"),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.tealAccent,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

