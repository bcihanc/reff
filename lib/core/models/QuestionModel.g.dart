// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QuestionModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) {
  return QuestionModel(
    header: json['header'] as String,
    content: json['content'] as String,
    answers: (json['answers'] as List)?.map((e) => e as String)?.toList(),
    imageUrl: json['imageUrl'] as String,
    timeStamp: json['timeStamp'] as String,
  )..id = json['id'] as String;
}

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'header': instance.header,
      'content': instance.content,
      'answers': instance.answers,
      'imageUrl': instance.imageUrl,
      'timeStamp': instance.timeStamp,
    };
