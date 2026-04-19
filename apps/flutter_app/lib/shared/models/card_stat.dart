import 'package:json_annotation/json_annotation.dart';

part 'card_stat.g.dart';

@JsonSerializable()
class CardStat {
  const CardStat({required this.label, required this.value});

  final String label;
  final String value;

  factory CardStat.fromJson(Map<String, dynamic> json) =>
      _$CardStatFromJson(json);

  Map<String, dynamic> toJson() => _$CardStatToJson(this);
}
