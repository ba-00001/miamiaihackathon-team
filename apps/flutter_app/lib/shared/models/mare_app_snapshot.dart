import 'package:json_annotation/json_annotation.dart';

import 'ai_error_state.dart';
import 'guest_experience.dart';
import 'role_experience.dart';
import 'storage_profile.dart';

part 'mare_app_snapshot.g.dart';

@JsonSerializable(explicitToJson: true)
class MareAppSnapshot {
  const MareAppSnapshot({
    required this.appName,
    required this.tagline,
    required this.updatedAt,
    required this.guest,
    required this.roles,
    required this.storage,
    required this.aiNotice,
  });

  final String appName;
  final String tagline;
  final String updatedAt;
  final GuestExperience guest;
  final List<RoleExperience> roles;
  final StorageProfile storage;
  final AiErrorState aiNotice;

  factory MareAppSnapshot.fromJson(Map<String, dynamic> json) =>
      _$MareAppSnapshotFromJson(json);

  Map<String, dynamic> toJson() => _$MareAppSnapshotToJson(this);
}
