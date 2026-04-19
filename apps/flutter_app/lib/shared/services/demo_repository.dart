import '../data/mock_growth_engine_snapshot.dart';
import '../models/growth_engine_snapshot.dart';

class DemoRepository {
  const DemoRepository();

  Future<GrowthEngineSnapshot> loadSnapshot() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return demoGrowthEngineSnapshot;
  }
}
