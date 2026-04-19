import 'package:json_annotation/json_annotation.dart';

part 'salon_profile.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SalonProfile {
  const SalonProfile({
    required this.id,
    required this.name,
    required this.location,
    this.websiteUrl,
    this.instagramHandle,
    required this.estimatedRevenue,
    required this.aestheticTags,
    required this.brandsCarried,
    required this.compatibilityScore,
  });

  final String id;
  final String name;
  final String location;
  final String? websiteUrl;
  final String? instagramHandle;
  final String estimatedRevenue;
  final List<String> aestheticTags;
  final List<String> brandsCarried;
  final int compatibilityScore;

  factory SalonProfile.fromJson(Map<String, dynamic> json) =>
      _$SalonProfileFromJson(json);

  Map<String, dynamic> toJson() => _$SalonProfileToJson(this);
}
