import 'package:json_annotation/json_annotation.dart';

part 'incentive_calculation.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class IncentiveCalculation {
  const IncentiveCalculation({
    required this.currentRetailConversionRate,
    required this.projectedRetailConversionRate,
    required this.estimatedAncillaryRevenue,
    required this.roiMultiplier,
  });

  final double currentRetailConversionRate;
  final double projectedRetailConversionRate;
  final double estimatedAncillaryRevenue;
  final double roiMultiplier;

  factory IncentiveCalculation.fromJson(Map<String, dynamic> json) =>
      _$IncentiveCalculationFromJson(json);

  Map<String, dynamic> toJson() => _$IncentiveCalculationToJson(this);
}
