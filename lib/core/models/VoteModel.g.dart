// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VoteModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AnswerModel _$_$_AnswerModelFromJson(Map<String, dynamic> json) {
  return _$_AnswerModel(
    id: json['id'] as String,
    userID: json['userID'] as String,
    questionID: json['questionID'] as String,
    answerID: json['answerID'] as String,
  );
}

Map<String, dynamic> _$_$_AnswerModelToJson(_$_AnswerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userID': instance.userID,
      'questionID': instance.questionID,
      'answerID': instance.answerID,
    };
