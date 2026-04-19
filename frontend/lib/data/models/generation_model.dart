class GenerationModel {
  final int id;
  final String modelType;
  final String prompt;
  final String? inputParams;
  final String? s3Key;
  final String? presignedUrl;
  final String mediaType;
  final String status;
  final DateTime createdAt;

  GenerationModel({
    required this.id,
    required this.modelType,
    required this.prompt,
    this.inputParams,
    this.s3Key,
    this.presignedUrl,
    required this.mediaType,
    required this.status,
    required this.createdAt,
  });

  factory GenerationModel.fromJson(Map<String, dynamic> json) {
    return GenerationModel(
      id: json['id'] ?? 0,
      modelType: json['model_type'] ?? '',
      prompt: json['prompt'] ?? '',
      inputParams: json['input_params'],
      s3Key: json['s3_key'],
      presignedUrl: json['presigned_url'],
      mediaType: json['media_type'] ?? 'video',
      status: json['status'] ?? 'unknown',
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }
}