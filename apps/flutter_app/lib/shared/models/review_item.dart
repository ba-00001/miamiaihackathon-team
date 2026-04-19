import 'package:json_annotation/json_annotation.dart';

part 'review_item.g.dart';

@JsonSerializable()
class ReviewItem {
  const ReviewItem({
    required this.id,
    required this.owner,
    required this.lane,
    required this.status,
    required this.nextAction,
    required this.fallback,
  });

  final String id;
  final String owner;
  final String lane;
  final String status;
  final String nextAction;
  final String fallback;

  factory ReviewItem.fromJson(Map<String, dynamic> json) =>
      _$ReviewItemFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewItemToJson(this);
}
