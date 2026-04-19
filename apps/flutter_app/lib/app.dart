import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'features/dashboard/dashboard_screen.dart';
import 'shared/providers/app_state_provider.dart';
import 'theme/mare_theme.dart';

class MareGrowthEngineApp extends StatelessWidget {
  const MareGrowthEngineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppStateNotifier>(
      create: (context) => AppStateNotifier()..loadSnapshot(),
      child: MaterialApp(
        title: 'MaRe',
        debugShowCheckedModeBanner: false,
        theme: buildMareTheme(),
home: DashboardScreen(),
      ),
    );
  }
}
