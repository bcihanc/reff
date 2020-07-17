// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'VoteModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoteModel _$VoteModelFromJson(Map<String, dynamic> json) {
  return VoteModel(
    userId: json['userId'] as String,
    questionId: json['questionId'] as String,
    answerId: json['answerId'] as String,
  )..id = json['id'] as String;
}

Map<String, dynamic> _$VoteModelToJson(VoteModel instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'questionId': instance.questionId,
      'answerId': instance.answerId,
    };
