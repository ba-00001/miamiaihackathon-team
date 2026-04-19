import 'package:json_annotation/json_annotation.dart';

import 'experience_section.dart';

part 'guest_experience.g.dart';

@JsonSerializable(explicitToJson: true)
class GuestExperience {
  const GuestExperience({
    required this.title,
    required this.description,
    required this.highlights,
    required this.sections,
  });

  final String title;
  final String description;
  final List<String> highlights;
  final List<ExperienceSection> sections;

  factory GuestExperience.fromJson(Map<String, dynamic> json) =>
      _$GuestExperienceFromJson(json);

  Map<String, dynamic> toJson() => _$GuestExperienceToJson(this);
}
