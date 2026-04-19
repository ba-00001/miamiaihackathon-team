// Removed unused imports
import 'package:dio/dio.dart';
import 'package:envied/envied.dart';

import '../data/mock_mare_app_snapshot.dart'; // Fallback
import '../models/mare_app_snapshot.dart';
import '../models/ai_error_state.dart';

part 'mare_app_repository.g.dart';

@Envied(name: 'Env', path: '.env')
abstract class Env {
  @EnviedField(varName: 'BACKEND_BASE_URL', defaultValue: 'http://localhost:4300')
  static const String backendBaseUrl = _Env.backendBaseUrl;
}

class MareAppRepository {
  static String get _baseUrl => _Env.backendBaseUrl;
  final Dio _dio = Dio(BaseOptions(
    baseUrl: _baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {'Content-Type': 'application/json'},
  ));

  Future<MareAppSnapshot> loadSnapshot() async {
    try {
      final response = await _dio.get('/api/snapshot');
      if (response.statusCode == 200) {
        return MareAppSnapshot.fromJson(response.data);
      }
      throw DioException(requestOptions: response.requestOptions);
    } on DioException catch (e) {
      // Fallback to mock on network error
      return _handleError(e);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>> agentRequest(Map<String, dynamic> input) async {
    try {
      final response = await _dio.post('/api/agent', data: input);
      return response.data;
    } catch (e) {
      return {'status': 'fallback', 'error': e.toString()};
    }
  }

  Future<Map<String, dynamic>> prepareUpload(String filename) async {
    try {
      final response = await _dio.get('/api/storage/prepare-upload?filename=$filename');
      return response.data;
    } catch (e) {
      return {'mode': 'fallback', 'error': e.toString()};
    }
  }

  MareAppSnapshot _handleError(dynamic error) {
    final mock = demoMareAppSnapshot;
    return MareAppSnapshot(
      appName: mock.appName,
      tagline: mock.tagline,
      updatedAt: mock.updatedAt,
      guest: mock.guest,
      roles: mock.roles,
      storage: mock.storage,
  aiNotice: AiErrorState(
    hasError: true,
    title: 'API Fallback Active',
    description: 'Backend error: ${error.toString()}. Using demo data. Yellow dot = guarded.',
    fallbacks: ['Start backend: cd backend && npm run dev', 'Retry: $_baseUrl/api/snapshot'],
  ),
    );
  }
}

