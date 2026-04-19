// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_experience.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoleExperience _$RoleExperienceFromJson(Map<String, dynamic> json) =>
    RoleExperience(
      id: json['id'] as String,
      title: json['title'] as String,
      audience: json['audience'] as String,
      summary: json['summary'] as String,
      heroTitle: json['heroTitle'] as String,
      heroDescription: json['heroDescription'] as String,
      quickActions: (json['quickActions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      sections: (json['sections'] as List<dynamic>)
          .map((e) => ExperienceSection.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RoleExperienceToJson(RoleExperience instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'audience': instance.audience,
      'summary': instance.summary,
      'heroTitle': instance.heroTitle,
      'heroDescription': instance.heroDescription,
      'quickActions': instance.quickActions,
      'sections': instance.sections.map((e) => e.toJson()).toList(),
    };
