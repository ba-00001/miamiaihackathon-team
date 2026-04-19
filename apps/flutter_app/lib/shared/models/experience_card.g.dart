// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experience_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExperienceCard _$ExperienceCardFromJson(Map<String, dynamic> json) =>
    ExperienceCard(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      detail: json['detail'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      stats: (json['stats'] as List<dynamic>)
          .map((e) => CardStat.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExperienceCardToJson(ExperienceCard instance) =>
    <String, dynamic>{
      'title': instance.title,
      'subtitle': instance.subtitle,
      'detail': instance.detail,
      'tags': instance.tags,
      'stats': instance.stats.map((e) => e.toJson()).toList(),
    };
