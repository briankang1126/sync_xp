import 'package:flutter/material.dart';
import 'package:sync_xp/features/index.dart';
class MatchMakingPage extends StatelessWidget {
  const MatchMakingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 38),
        color: Colors.teal.shade800.withOpacity(0.85),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
        child: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              // Blank Avatar (no image)
              CircleAvatar(
                radius: 36,
                backgroundColor: Colors.tealAccent,
                child: Icon(Icons.person, size: 40, color: Colors.black54),
              ),
              SizedBox(height: 16),
              Text("Name: (blank)", style: TextStyle(color: Colors.white)),
              Text("Sports: (blank)", style: TextStyle(color: Colors.white)),
              Text("Description: (blank)", style: TextStyle(color: Colors.white70)),
            ],
          ),
        ),
      ),
    );
  }
}
