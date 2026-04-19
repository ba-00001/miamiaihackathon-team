import 'package:json_annotation/json_annotation.dart';

part 'metric_summary.g.dart';

@JsonSerializable()
class MetricSummary {
  const MetricSummary({
    required this.luxuryProspects,
    required this.approvedOutreach,
    required this.contentAssetsReady,
    required this.retailLiftPotential,
  });

  final int luxuryProspects;
  final int approvedOutreach;
  final int contentAssetsReady;
  final String retailLiftPotential;

  factory MetricSummary.fromJson(Map<String, dynamic> json) =>
      _$MetricSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$MetricSummaryToJson(this);
}
