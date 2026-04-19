import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/mare_theme.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const ProviderScope(child: MareGrowthEngineApp()));
}

class MareGrowthEngineApp extends StatelessWidget {
  const MareGrowthEngineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MaRe',
      debugShowCheckedModeBanner: false,
      theme: buildMareTheme(),
      home: const DashboardScreen(),
    );
  }
}