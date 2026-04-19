// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guest_experience.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuestExperience _$GuestExperienceFromJson(Map<String, dynamic> json) =>
    GuestExperience(
      title: json['title'] as String,
      description: json['description'] as String,
      highlights: (json['highlights'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      sections: (json['sections'] as List<dynamic>)
          .map((e) => ExperienceSection.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GuestExperienceToJson(GuestExperience instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'highlights': instance.highlights,
      'sections': instance.sections.map((e) => e.toJson()).toList(),
    };
