// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewItem _$ReviewItemFromJson(Map<String, dynamic> json) => ReviewItem(
  id: json['id'] as String,
  owner: json['owner'] as String,
  lane: json['lane'] as String,
  status: json['status'] as String,
  nextAction: json['nextAction'] as String,
  fallback: json['fallback'] as String,
);

Map<String, dynamic> _$ReviewItemToJson(ReviewItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'owner': instance.owner,
      'lane': instance.lane,
      'status': instance.status,
      'nextAction': instance.nextAction,
      'fallback': instance.fallback,
    };
