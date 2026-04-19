// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outreach_draft.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutreachDraft _$OutreachDraftFromJson(Map<String, dynamic> json) =>
    OutreachDraft(
      salonName: json['salonName'] as String,
      channel: json['channel'] as String,
      subjectLine: json['subjectLine'] as String,
      hook: json['hook'] as String,
      body: json['body'] as String,
      postcardConcept: json['postcardConcept'] as String,
      guardrail: json['guardrail'] as String,
    );

Map<String, dynamic> _$OutreachDraftToJson(OutreachDraft instance) =>
    <String, dynamic>{
      'salonName': instance.salonName,
      'channel': instance.channel,
      'subjectLine': instance.subjectLine,
      'hook': instance.hook,
      'body': instance.body,
      'postcardConcept': instance.postcardConcept,
      'guardrail': instance.guardrail,
    };
