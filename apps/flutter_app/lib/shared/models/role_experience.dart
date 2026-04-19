import 'package:json_annotation/json_annotation.dart';

import 'experience_section.dart';

part 'role_experience.g.dart';

@JsonSerializable(explicitToJson: true)
class RoleExperience {
  const RoleExperience({
    required this.id,
    required this.title,
    required this.audience,
    required this.summary,
    required this.heroTitle,
    required this.heroDescription,
    required this.quickActions,
    required this.sections,
  });

  final String id;
  final String title;
  final String audience;
  final String summary;
  final String heroTitle;
  final String heroDescription;
  final List<String> quickActions;
  final List<ExperienceSection> sections;

  factory RoleExperience.fromJson(Map<String, dynamic> json) =>
      _$RoleExperienceFromJson(json);

  Map<String, dynamic> toJson() => _$RoleExperienceToJson(this);
}
