// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StorageProfile _$StorageProfileFromJson(Map<String, dynamic> json) =>
    StorageProfile(
      provider: json['provider'] as String,
      bucket: json['bucket'] as String,
      region: json['region'] as String,
      prefix: json['prefix'] as String,
      mode: json['mode'] as String,
      fallback: json['fallback'] as String,
    );

Map<String, dynamic> _$StorageProfileToJson(StorageProfile instance) =>
    <String, dynamic>{
      'provider': instance.provider,
      'bucket': instance.bucket,
      'region': instance.region,
      'prefix': instance.prefix,
      'mode': instance.mode,
      'fallback': instance.fallback,
    };
