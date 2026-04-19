import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const ProviderScope(child: MiamiAIApp()));
}

class MiamiAIApp extends StatelessWidget {
  const MiamiAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Miami AI Studio',
      theme: appTheme,
      home: const HomeScreen(),
    );
  }
}