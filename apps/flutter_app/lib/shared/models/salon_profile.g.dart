// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'salon_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalonProfile _$SalonProfileFromJson(Map<String, dynamic> json) => SalonProfile(
  id: json['id'] as String,
  name: json['name'] as String,
  location: json['location'] as String,
  websiteUrl: json['website_url'] as String?,
  instagramHandle: json['instagram_handle'] as String?,
  estimatedRevenue: json['estimated_revenue'] as String,
  aestheticTags: (json['aesthetic_tags'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  brandsCarried: (json['brands_carried'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  compatibilityScore: (json['compatibility_score'] as num).toInt(),
);

Map<String, dynamic> _$SalonProfileToJson(SalonProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'location': instance.location,
      'website_url': instance.websiteUrl,
      'instagram_handle': instance.instagramHandle,
      'estimated_revenue': instance.estimatedRevenue,
      'aesthetic_tags': instance.aestheticTags,
      'brands_carried': instance.brandsCarried,
      'compatibility_score': instance.compatibilityScore,
    };
