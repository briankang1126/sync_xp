import 'package:flutter/material.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.teal.shade800.withOpacity(0.8),
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Text(
            "Events Section",
            style: TextStyle(
                color: Colors.tealAccent[100], fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1.1),
          ),
        ),
      ),
    );
  }
}

class ARConnectPage extends StatelessWidget {
  const ARConnectPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.teal.shade800.withOpacity(0.8),
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Text(
            "AR Connect Section",
            style: TextStyle(
                color: Colors.tealAccent[100], fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1.1),
          ),
        ),
      ),
    );
  }
}
