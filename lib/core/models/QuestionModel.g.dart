// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QuestionModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_QuestionModel _$_$_QuestionModelFromJson(Map<String, dynamic> json) {
  return _$_QuestionModel(
    id: json['id'] as String,
    header: json['header'] as String,
    content: json['content'] as String,
    answers: (json['answers'] as List)?.map((e) => e as String)?.toList(),
    imageUrl: json['imageUrl'] as String,
    timeStamp: json['timeStamp'] == null
        ? null
        : DateTime.parse(json['timeStamp'] as String),
  );
}

Map<String, dynamic> _$_$_QuestionModelToJson(_$_QuestionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'header': instance.header,
      'content': instance.content,
      'answers': instance.answers,
      'imageUrl': instance.imageUrl,
      'timeStamp': instance.timeStamp?.toIso8601String(),
    };
