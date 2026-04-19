import 'package:json_annotation/json_annotation.dart';

import 'card_stat.dart';

part 'experience_card.g.dart';

@JsonSerializable(explicitToJson: true)
class ExperienceCard {
  const ExperienceCard({
    required this.title,
    required this.subtitle,
    required this.detail,
    required this.tags,
    required this.stats,
  });

  final String title;
  final String subtitle;
  final String detail;
  final List<String> tags;
  final List<CardStat> stats;

  factory ExperienceCard.fromJson(Map<String, dynamic> json) =>
      _$ExperienceCardFromJson(json);

  Map<String, dynamic> toJson() => _$ExperienceCardToJson(this);
}
