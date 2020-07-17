// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AnswerModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnswerModel _$AnswerModelFromJson(Map<String, dynamic> json) {
  return AnswerModel(
    content: json['content'] as String,
    imageUrl: json['imageUrl'] as String,
    color: const ColorJsonConverter().fromJson(json['color'] as String),
  )..id = json['id'] as String;
}

Map<String, dynamic> _$AnswerModelToJson(AnswerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'imageUrl': instance.imageUrl,
      'color': const ColorJsonConverter().toJson(instance.color),
    };
