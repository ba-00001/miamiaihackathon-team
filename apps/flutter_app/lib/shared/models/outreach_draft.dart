import 'package:json_annotation/json_annotation.dart';

import 'incentive_calculation.dart';

part 'outreach_draft.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class OutreachDraft {
  const OutreachDraft({
    required this.salonId,
    required this.hook,
    required this.valueProp,
    required this.guardrail,
    required this.fullMessage,
    this.incentives,
    required this.status,
  });

  final String salonId;
  final String hook;
  final String valueProp;
  final String guardrail;
  final String fullMessage;
  final IncentiveCalculation? incentives;
  final String status;

  factory OutreachDraft.fromJson(Map<String, dynamic> json) =>
      _$OutreachDraftFromJson(json);

  Map<String, dynamic> toJson() => _$OutreachDraftToJson(this);
}
