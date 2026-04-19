import 'package:json_annotation/json_annotation.dart';

part 'outreach_draft.g.dart';

@JsonSerializable()
class OutreachDraft {
  const OutreachDraft({
    required this.salonName,
    required this.channel,
    required this.subjectLine,
    required this.hook,
    required this.body,
    required this.postcardConcept,
    required this.guardrail,
  });

  final String salonName;
  final String channel;
  final String subjectLine;
  final String hook;
  final String body;
  final String postcardConcept;
  final String guardrail;

  factory OutreachDraft.fromJson(Map<String, dynamic> json) =>
      _$OutreachDraftFromJson(json);

  Map<String, dynamic> toJson() => _$OutreachDraftToJson(this);
}
