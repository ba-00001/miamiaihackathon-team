// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outreach_draft.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutreachDraft _$OutreachDraftFromJson(Map<String, dynamic> json) =>
    OutreachDraft(
      salonId: json['salon_id'] as String,
      hook: json['hook'] as String,
      valueProp: json['value_prop'] as String,
      guardrail: json['guardrail'] as String,
      fullMessage: json['full_message'] as String,
      incentives: json['incentives'] == null
          ? null
          : IncentiveCalculation.fromJson(
              json['incentives'] as Map<String, dynamic>,
            ),
      status: json['status'] as String,
    );

Map<String, dynamic> _$OutreachDraftToJson(OutreachDraft instance) =>
    <String, dynamic>{
      'salon_id': instance.salonId,
      'hook': instance.hook,
      'value_prop': instance.valueProp,
      'guardrail': instance.guardrail,
      'full_message': instance.fullMessage,
      'incentives': instance.incentives?.toJson(),
      'status': instance.status,
    };
