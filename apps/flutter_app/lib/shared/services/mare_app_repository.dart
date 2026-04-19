import '../data/mock_mare_app_snapshot.dart';
import '../models/mare_app_snapshot.dart';

class MareAppRepository {
  const MareAppRepository();

  Future<MareAppSnapshot> loadSnapshot() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return demoMareAppSnapshot;
  }
}
