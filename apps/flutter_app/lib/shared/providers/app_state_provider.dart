import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../models/mare_app_snapshot.dart';
import '../services/mare_app_repository.dart';

import '../models/mare_app_snapshot.dart';
import '../services/mare_app_repository.dart';

class AppStateNotifier extends ChangeNotifier {
  MareAppSnapshot? _snapshot;
  final MareAppRepository _repo = MareAppRepository();

  MareAppSnapshot? get snapshot => _snapshot;
  bool get isLoading => _snapshot == null;

  Future<void> loadSnapshot() async {
    try {
      _snapshot = await _repo.loadSnapshot();
      notifyListeners();
    } catch (e) {
      // Fallback handled in repo
      _snapshot = await _repo.loadSnapshot(); // Triggers fallback
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    await loadSnapshot();
  }
}

ChangeNotifierProvider<AppStateNotifier> get appStateProvider => ChangeNotifierProvider(
  create: (context) => AppStateNotifier()..loadSnapshot(),
);


