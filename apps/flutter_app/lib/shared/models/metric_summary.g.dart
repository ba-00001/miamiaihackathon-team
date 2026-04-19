// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metric_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetricSummary _$MetricSummaryFromJson(Map<String, dynamic> json) =>
    MetricSummary(
      luxuryProspects: (json['luxuryProspects'] as num).toInt(),
      approvedOutreach: (json['approvedOutreach'] as num).toInt(),
      contentAssetsReady: (json['contentAssetsReady'] as num).toInt(),
      retailLiftPotential: json['retailLiftPotential'] as String,
    );

Map<String, dynamic> _$MetricSummaryToJson(MetricSummary instance) =>
    <String, dynamic>{
      'luxuryProspects': instance.luxuryProspects,
      'approvedOutreach': instance.approvedOutreach,
      'contentAssetsReady': instance.contentAssetsReady,
      'retailLiftPotential': instance.retailLiftPotential,
    };
