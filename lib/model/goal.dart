// @dart=2.9

import 'package:json_annotation/json_annotation.dart';

Goal _$GoalFromJson(Map<String, dynamic> json) {
  return Goal()
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..image = json['image'] as String
    ..amount = json['amount'] as int
    ..currency = json['currency'] as String
    ..duration = json['duration'] as int
    ..durationType = json['duration_type'] as String
    ..createdAt = json['created_at'] as int
    ..state = json['state'] as String;
}

Map<String, dynamic> _$GoalToJson(Goal instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'amount': instance.amount,
      'currency': instance.currency,
      'duration': instance.duration,
      'duration_type': instance.durationType,
      'created_at': instance.createdAt,
      'state': instance.state,
    };

@JsonSerializable()
class Goal {
  @JsonKey(name: "id")
  String id;

  @JsonKey(name: "name")
  String name;

  @JsonKey(name: "image")
  String image;

  @JsonKey(name: "amount")
  int amount;

  @JsonKey(name: "currency")
  String currency;

  @JsonKey(name: "duration")
  int duration;

  @JsonKey(name: "duration_type")
  String durationType;

  @JsonKey(name: "created_at")
  int createdAt;

  @JsonKey(name: "state")
  String state;

  Goal();

  factory Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);
  Map<String, dynamic> toJson() => _$GoalToJson(this);
}
