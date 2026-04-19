// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incentive_calculation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IncentiveCalculation _$IncentiveCalculationFromJson(
  Map<String, dynamic> json,
) => IncentiveCalculation(
  currentRetailConversionRate: (json['current_retail_conversion_rate'] as num)
      .toDouble(),
  projectedRetailConversionRate:
      (json['projected_retail_conversion_rate'] as num).toDouble(),
  estimatedAncillaryRevenue: (json['estimated_ancillary_revenue'] as num)
      .toDouble(),
  roiMultiplier: (json['roi_multiplier'] as num).toDouble(),
);

Map<String, dynamic> _$IncentiveCalculationToJson(
  IncentiveCalculation instance,
) => <String, dynamic>{
  'current_retail_conversion_rate': instance.currentRetailConversionRate,
  'projected_retail_conversion_rate': instance.projectedRetailConversionRate,
  'estimated_ancillary_revenue': instance.estimatedAncillaryRevenue,
  'roi_multiplier': instance.roiMultiplier,
};
