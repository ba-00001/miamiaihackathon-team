import 'package:json_annotation/json_annotation.dart';

part 'storage_profile.g.dart';

@JsonSerializable()
class StorageProfile {
  const StorageProfile({
    required this.provider,
    required this.bucket,
    required this.region,
    required this.prefix,
    required this.mode,
    required this.fallback,
  });

  final String provider;
  final String bucket;
  final String region;
  final String prefix;
  final String mode;
  final String fallback;

  factory StorageProfile.fromJson(Map<String, dynamic> json) =>
      _$StorageProfileFromJson(json);

  Map<String, dynamic> toJson() => _$StorageProfileToJson(this);
}
