import 'package:json_annotation/json_annotation.dart';

part 'ai_error_state.g.dart';

@JsonSerializable()
class AiErrorState {
  const AiErrorState({
    required this.hasError,
    required this.title,
    required this.description,
    required this.fallbacks,
  });

  final bool hasError;
  final String title;
  final String description;
  final List<String> fallbacks;

  factory AiErrorState.fromJson(Map<String, dynamic> json) =>
      _$AiErrorStateFromJson(json);

  Map<String, dynamic> toJson() => _$AiErrorStateToJson(this);
}
