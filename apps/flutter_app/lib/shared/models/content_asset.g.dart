// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_asset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentAsset _$ContentAssetFromJson(Map<String, dynamic> json) => ContentAsset(
  id: json['id'] as String,
  format: json['format'] as String,
  title: json['title'] as String,
  primaryKeyword: json['primaryKeyword'] as String,
  openingHook: json['openingHook'] as String,
  talkingPoints: (json['talkingPoints'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  callToAction: json['callToAction'] as String,
  status: json['status'] as String,
);

Map<String, dynamic> _$ContentAssetToJson(ContentAsset instance) =>
    <String, dynamic>{
      'id': instance.id,
      'format': instance.format,
      'title': instance.title,
      'primaryKeyword': instance.primaryKeyword,
      'openingHook': instance.openingHook,
      'talkingPoints': instance.talkingPoints,
      'callToAction': instance.callToAction,
      'status': instance.status,
    };
