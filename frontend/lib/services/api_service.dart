import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../core/constants.dart';
import '../data/models/generation_model.dart';

class ApiService {
  static final String _base = AppConstants.apiBaseUrl;

  // ── Generic POST (JSON) ────────────────────────────────
  static Future<Map<String, dynamic>> _post(
      String path, Map<String, dynamic> body) async {
    final uri = Uri.parse('$_base$path');
    final response = await http
        .post(
          uri,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body),
        )
        .timeout(const Duration(minutes: 5)); // Modelslab can be slow

    if (response.statusCode >= 400) {
      try {
        final err = jsonDecode(response.body);
        throw Exception(err['error'] ?? 'Request failed (${response.statusCode})');
      } catch (_) {
        throw Exception('Request failed (${response.statusCode}): ${response.body}');
      }
    }
    return jsonDecode(response.body);
  }

  // ── Upload file bytes → S3, returns PUBLIC URL ─────────
  static Future<String> uploadFileBytes(
      Uint8List bytes, String filename, String mimeType) async {
    final uri = Uri.parse('$_base/api/upload');
    final req = http.MultipartRequest('POST', uri)
      ..files.add(http.MultipartFile.fromBytes(
        'file',
        bytes,
        filename: filename,
        contentType: MediaType.parse(mimeType),
      ));
    final streamed = await req.send().timeout(const Duration(seconds: 60));
    final body = await streamed.stream.bytesToString();
    if (streamed.statusCode >= 400) {
      throw Exception('Upload failed: $body');
    }
    final json = jsonDecode(body);
    // Prefer public_url (direct S3 URL), fall back to presigned_url
    return (json['public_url'] ?? json['presigned_url']) as String;
  }

  // ── Upload URL → S3, returns PUBLIC URL ────────────────
  static Future<String> uploadFromUrl(String url) async {
    final json = await _post('/api/upload', {'url': url});
    return (json['public_url'] ?? json['presigned_url']) as String;
  }

  // ── Model endpoints ────────────────────────────────────
  static Future<GenerationModel> generateSeedance(
      Map<String, dynamic> params) async {
    final json = await _post('/api/seedance', params);
    return GenerationModel.fromJson(json);
  }

  static Future<GenerationModel> generateWan(
      Map<String, dynamic> params) async {
    final json = await _post('/api/wan', params);
    return GenerationModel.fromJson(json);
  }

  // ── History ────────────────────────────────────────────
  static Future<List<GenerationModel>> getHistory({String? modelType}) async {
    String path = '/api/generations';
    if (modelType != null) path += '?model_type=$modelType';
    final uri = Uri.parse('$_base$path');
    final response = await http.get(uri);
    if (response.statusCode >= 400) throw Exception('Failed to load history');
    final List<dynamic> list = jsonDecode(response.body);
    return list.map((j) => GenerationModel.fromJson(j)).toList();
  }

  // ── Delete ─────────────────────────────────────────────
  static Future<void> deleteGeneration(int id) async {
    final uri = Uri.parse('$_base/api/generations/$id');
    await http.delete(uri);
  }
}