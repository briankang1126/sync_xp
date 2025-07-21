import 'package:flutter/material.dart';
import 'package:sync_xp/features/matchmaking.dart';
import 'package:sync_xp/features/game.dart';
import 'package:sync_xp/features/event.dart';

const String kBgImg = 'https://i.imgur.com/qMvzsmi.jpeg';

const List<String> websiteSections = [
  'Home',
  'Match Making',
  'Games',
  'Events',
  'AR Connect',
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedSection = websiteSections[0];

  void _navigateToSection(String? section) {
    if (section == null || section == _selectedSection) return;
    setState(() => _selectedSection = section);
  }

  @override
  Widget build(BuildContext context) {
    Widget bodyWidget;
    switch (_selectedSection) {
      case 'Match Making':
        bodyWidget = const MatchMakingPage();
        break;
      case 'Games':
        bodyWidget = const GamesPage();
        break;
      case 'Events':
        bodyWidget = const EventsPage();
        break;
      case 'AR Connect':
        bodyWidget = const ARConnectPage();
        break;
      default:
        bodyWidget = const MainMenuPage();
    }
    return Scaffold(
      body: Stack(
        children: [
          // Background Image + Overlay
          Positioned.fill(
            child: Image.network(kBgImg, fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.6)),
          ),
          // Content
          SafeArea(
            child: Column(
              children: [
                const AppLogo(),
                // Dropdown Navigation
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                  child: DropdownButton<String>(
                    value: _selectedSection,
                    onChanged: _navigateToSection,
                    items: websiteSections
                        .map((s) => DropdownMenuItem(
                              value: s,
                              child: Text(s,
                                  style: const TextStyle(
                                      color: Colors.tealAccent,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold)),
                            ))
                        .toList(),
                    dropdownColor: Colors.black87,
                    style: const TextStyle(color: Colors.tealAccent, fontSize: 18),
                    underline: Container(height: 2, color: Colors.tealAccent),
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.tealAccent),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(child: bodyWidget),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Logo at the top center
class AppLogo extends StatelessWidget {
  const AppLogo({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 38,
            backgroundColor: Colors.tealAccent,
            child: Icon(Icons.sports_basketball, size: 38, color: Colors.black),
          ),
          const SizedBox(height: 6),
          Text(
            'SyncXP',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.tealAccent,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
          ),
        ],
      ),
    );
  }
}

// --------- Main Menu Example Page ----------
class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _menuButton("Match Making"),
          const SizedBox(height: 18),
          _menuButton("Games"),
          const SizedBox(height: 18),
          _menuButton("Events"),
          const SizedBox(height: 18),
          _menuButton("AR Connect"),
        ],
      ),
    );
  }

  Widget _menuButton(String label) {
    return SizedBox(
      width: 220,
      child: ElevatedButton(
        onPressed: () {}, // Navigation handled by dropdown
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.tealAccent.shade700,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 17),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
      ),
    );
  }
}
