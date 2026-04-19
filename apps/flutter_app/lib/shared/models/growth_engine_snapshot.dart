import 'package:json_annotation/json_annotation.dart';

import 'ai_error_state.dart';
import 'content_asset.dart';
import 'metric_summary.dart';
import 'outreach_draft.dart';
import 'prospect_signal.dart';
import 'review_item.dart';

part 'growth_engine_snapshot.g.dart';

@JsonSerializable(explicitToJson: true)
class GrowthEngineSnapshot {
  const GrowthEngineSnapshot({
    required this.generatedAt,
    required this.marketFocus,
    required this.headline,
    required this.statusDotColor,
    required this.metrics,
    required this.aiError,
    required this.prospects,
    required this.outreachDrafts,
    required this.contentAssets,
    required this.reviewQueue,
  });

  final String generatedAt;
  final String marketFocus;
  final String headline;
  final String statusDotColor;
  final MetricSummary metrics;
  final AiErrorState aiError;
  final List<ProspectSignal> prospects;
  final List<OutreachDraft> outreachDrafts;
  final List<ContentAsset> contentAssets;
  final List<ReviewItem> reviewQueue;

  factory GrowthEngineSnapshot.fromJson(Map<String, dynamic> json) =>
      _$GrowthEngineSnapshotFromJson(json);

  Map<String, dynamic> toJson() => _$GrowthEngineSnapshotToJson(this);
}
