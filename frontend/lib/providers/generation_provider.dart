import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/generation_model.dart';
import '../services/api_service.dart';

final historyProvider = FutureProvider.family<List<GenerationModel>, String?>((ref, modelType) async {
  return ApiService.getHistory(modelType: modelType);
});

enum GenStatus { idle, loading, success, error }

class GenState {
  final GenStatus status;
  final GenerationModel? result;
  final String? error;
  const GenState({this.status = GenStatus.idle, this.result, this.error});
}

class GenNotifier extends StateNotifier<GenState> {
  GenNotifier() : super(const GenState());

  Future<void> generate(String modelType, Map<String, dynamic> params) async {
    state = const GenState(status: GenStatus.loading);
    try {
      late GenerationModel result;
      switch (modelType) {
        case 'seedance':
          result = await ApiService.generateSeedance(params);
          break;
        case 'wan':
          result = await ApiService.generateWan(params);
          break;
        default:
          throw Exception('Unknown model: $modelType');
      }
      state = GenState(status: GenStatus.success, result: result);
    } catch (e) {
      state = GenState(status: GenStatus.error, error: e.toString());
    }
  }

  void reset() => state = const GenState();
}

final genProvider = StateNotifierProvider<GenNotifier, GenState>((ref) => GenNotifier());