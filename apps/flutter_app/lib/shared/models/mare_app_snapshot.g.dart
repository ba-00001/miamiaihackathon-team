// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mare_app_snapshot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MareAppSnapshot _$MareAppSnapshotFromJson(Map<String, dynamic> json) =>
    MareAppSnapshot(
      appName: json['appName'] as String,
      tagline: json['tagline'] as String,
      updatedAt: json['updatedAt'] as String,
      guest: GuestExperience.fromJson(json['guest'] as Map<String, dynamic>),
      roles: (json['roles'] as List<dynamic>)
          .map((e) => RoleExperience.fromJson(e as Map<String, dynamic>))
          .toList(),
      storage: StorageProfile.fromJson(json['storage'] as Map<String, dynamic>),
      aiNotice: AiErrorState.fromJson(json['aiNotice'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MareAppSnapshotToJson(MareAppSnapshot instance) =>
    <String, dynamic>{
      'appName': instance.appName,
      'tagline': instance.tagline,
      'updatedAt': instance.updatedAt,
      'guest': instance.guest.toJson(),
      'roles': instance.roles.map((e) => e.toJson()).toList(),
      'storage': instance.storage.toJson(),
      'aiNotice': instance.aiNotice.toJson(),
    };
