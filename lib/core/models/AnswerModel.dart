import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:reff/core/utils/json_converters.dart';

part 'AnswerModel.g.dart';

@JsonSerializable()
@ColorJsonConverter()
class AnswerModel {
  String id;
  final String content;
  final String imageUrl;
  final Color color;

  AnswerModel({this.content, this.imageUrl, this.color});

  factory AnswerModel.fromJson(Map<String, dynamic> json) =>
      _$AnswerModelFromJson(json);
  Map<String, dynamic> toJson() => _$AnswerModelToJson(this);
}
