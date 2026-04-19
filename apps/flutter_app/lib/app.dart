import 'package:flutter/material.dart';

import 'features/dashboard/dashboard_screen.dart';
import 'theme/mare_theme.dart';

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
