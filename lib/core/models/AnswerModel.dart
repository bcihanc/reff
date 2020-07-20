import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'AnswerModel.freezed.dart';
part 'AnswerModel.g.dart';

@freezed
abstract class AnswerModel with _$AnswerModel {
  const factory AnswerModel({
    @nullable String id,
    @required String content,
    @nullable String imageUrl,
  }) = _AnswerModel;

  factory AnswerModel.fromJson(Map<String, dynamic> json) =>
      _$AnswerModelFromJson(json);
}
