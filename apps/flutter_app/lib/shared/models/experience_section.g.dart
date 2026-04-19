// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experience_section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExperienceSection _$ExperienceSectionFromJson(Map<String, dynamic> json) =>
    ExperienceSection(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      cards: (json['cards'] as List<dynamic>)
          .map((e) => ExperienceCard.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExperienceSectionToJson(ExperienceSection instance) =>
    <String, dynamic>{
      'title': instance.title,
      'subtitle': instance.subtitle,
      'cards': instance.cards.map((e) => e.toJson()).toList(),
    };
