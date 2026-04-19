import 'package:json_annotation/json_annotation.dart';

import 'experience_card.dart';

part 'experience_section.g.dart';

@JsonSerializable(explicitToJson: true)
class ExperienceSection {
  const ExperienceSection({
    required this.title,
    required this.subtitle,
    required this.cards,
  });

  final String title;
  final String subtitle;
  final List<ExperienceCard> cards;

  factory ExperienceSection.fromJson(Map<String, dynamic> json) =>
      _$ExperienceSectionFromJson(json);

  Map<String, dynamic> toJson() => _$ExperienceSectionToJson(this);
}
