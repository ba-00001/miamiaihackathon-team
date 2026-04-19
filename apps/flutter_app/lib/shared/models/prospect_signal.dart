import 'package:json_annotation/json_annotation.dart';

part 'prospect_signal.g.dart';

@JsonSerializable()
class ProspectSignal {
  const ProspectSignal({
    required this.id,
    required this.name,
    required this.cityState,
    required this.revenueBand,
    required this.aestheticSignal,
    required this.locations,
    required this.fitScore,
    required this.socialHook,
    required this.reasons,
  });

  final String id;
  final String name;
  final String cityState;
  final String revenueBand;
  final String aestheticSignal;
  final int locations;
  final double fitScore;
  final String socialHook;
  final List<String> reasons;

  factory ProspectSignal.fromJson(Map<String, dynamic> json) =>
      _$ProspectSignalFromJson(json);

  Map<String, dynamic> toJson() => _$ProspectSignalToJson(this);
}
