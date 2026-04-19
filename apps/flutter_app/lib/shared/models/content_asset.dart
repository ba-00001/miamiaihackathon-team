import 'package:json_annotation/json_annotation.dart';

part 'content_asset.g.dart';

@JsonSerializable()
class ContentAsset {
  const ContentAsset({
    required this.id,
    required this.format,
    required this.title,
    required this.primaryKeyword,
    required this.openingHook,
    required this.talkingPoints,
    required this.callToAction,
    required this.status,
  });

  final String id;
  final String format;
  final String title;
  final String primaryKeyword;
  final String openingHook;
  final List<String> talkingPoints;
  final String callToAction;
  final String status;

  factory ContentAsset.fromJson(Map<String, dynamic> json) =>
      _$ContentAssetFromJson(json);

  Map<String, dynamic> toJson() => _$ContentAssetToJson(this);
}
