// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prospect_signal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProspectSignal _$ProspectSignalFromJson(Map<String, dynamic> json) =>
    ProspectSignal(
      id: json['id'] as String,
      name: json['name'] as String,
      cityState: json['cityState'] as String,
      revenueBand: json['revenueBand'] as String,
      aestheticSignal: json['aestheticSignal'] as String,
      locations: (json['locations'] as num).toInt(),
      fitScore: (json['fitScore'] as num).toDouble(),
      socialHook: json['socialHook'] as String,
      reasons: (json['reasons'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ProspectSignalToJson(ProspectSignal instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'cityState': instance.cityState,
      'revenueBand': instance.revenueBand,
      'aestheticSignal': instance.aestheticSignal,
      'locations': instance.locations,
      'fitScore': instance.fitScore,
      'socialHook': instance.socialHook,
      'reasons': instance.reasons,
    };
