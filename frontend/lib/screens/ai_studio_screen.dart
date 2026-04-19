import 'package:flutter/material.dart';
import '../core/mare_theme.dart';
import 'generate_screen.dart';
import 'history_screen.dart';

class AiStudioScreen extends StatefulWidget {
  const AiStudioScreen({super.key});
  @override
  State<AiStudioScreen> createState() => _AiStudioScreenState();
}

class _AiStudioScreenState extends State<AiStudioScreen> {
  int _tab = 0;
  final _pages = const [GenerateScreen(), HistoryScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MaRe Creative Engine'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _pages[_tab],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: MareColors.pearl,
          border: Border(top: BorderSide(color: MareColors.border, width: 1)),
        ),
        child: BottomNavigationBar(
          currentIndex: _tab,
          onTap: (i) => setState(() => _tab = i),
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: MareColors.ink,
          unselectedItemColor: MareColors.espresso,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: 'Studio'),
            BottomNavigationBarItem(icon: Icon(Icons.history_rounded), label: 'Library'),
          ],
        ),
      ),
    );
  }
}