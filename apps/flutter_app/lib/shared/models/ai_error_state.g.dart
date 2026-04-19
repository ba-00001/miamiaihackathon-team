// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_error_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AiErrorState _$AiErrorStateFromJson(Map<String, dynamic> json) => AiErrorState(
  hasError: json['hasError'] as bool,
  title: json['title'] as String,
  description: json['description'] as String,
  fallbacks: (json['fallbacks'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$AiErrorStateToJson(AiErrorState instance) =>
    <String, dynamic>{
      'hasError': instance.hasError,
      'title': instance.title,
      'description': instance.description,
      'fallbacks': instance.fallbacks,
    };
