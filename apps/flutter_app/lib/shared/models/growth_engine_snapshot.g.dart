// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'growth_engine_snapshot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrowthEngineSnapshot _$GrowthEngineSnapshotFromJson(
  Map<String, dynamic> json,
) => GrowthEngineSnapshot(
  generatedAt: json['generatedAt'] as String,
  marketFocus: json['marketFocus'] as String,
  headline: json['headline'] as String,
  statusDotColor: json['statusDotColor'] as String,
  metrics: MetricSummary.fromJson(json['metrics'] as Map<String, dynamic>),
  aiError: AiErrorState.fromJson(json['aiError'] as Map<String, dynamic>),
  prospects: (json['prospects'] as List<dynamic>)
      .map((e) => ProspectSignal.fromJson(e as Map<String, dynamic>))
      .toList(),
  outreachDrafts: (json['outreachDrafts'] as List<dynamic>)
      .map((e) => OutreachDraft.fromJson(e as Map<String, dynamic>))
      .toList(),
  contentAssets: (json['contentAssets'] as List<dynamic>)
      .map((e) => ContentAsset.fromJson(e as Map<String, dynamic>))
      .toList(),
  reviewQueue: (json['reviewQueue'] as List<dynamic>)
      .map((e) => ReviewItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$GrowthEngineSnapshotToJson(
  GrowthEngineSnapshot instance,
) => <String, dynamic>{
  'generatedAt': instance.generatedAt,
  'marketFocus': instance.marketFocus,
  'headline': instance.headline,
  'statusDotColor': instance.statusDotColor,
  'metrics': instance.metrics.toJson(),
  'aiError': instance.aiError.toJson(),
  'prospects': instance.prospects.map((e) => e.toJson()).toList(),
  'outreachDrafts': instance.outreachDrafts.map((e) => e.toJson()).toList(),
  'contentAssets': instance.contentAssets.map((e) => e.toJson()).toList(),
  'reviewQueue': instance.reviewQueue.map((e) => e.toJson()).toList(),
};
