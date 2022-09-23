// @dart=2.9

import 'package:json_annotation/json_annotation.dart';

UnsplashModel _$UnsplashModelFromJson(Map<String, dynamic> json) {
  print(json['urls']['small']);
  return UnsplashModel()
    ..id = json['id'] as String
    ..url = json['urls']['small'] as String;
}

Map<String, dynamic> _$UnsplashModelToJson(UnsplashModel instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
    };

@JsonSerializable()
class UnsplashModel {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'url')
  String url;

  UnsplashModel({
    this.id,
    this.url,
  });

  factory UnsplashModel.fromJson(Map<String, dynamic> json) => _$UnsplashModelFromJson(json);
  Map<String, dynamic> toJson() => _$UnsplashModelToJson(this);
}
