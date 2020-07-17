import 'package:json_annotation/json_annotation.dart';

part 'VoteModel.g.dart';

@JsonSerializable()
class VoteModel {
  String id;
  final String userId;
  final String questionId;
  final String answerId;

  VoteModel({this.userId, this.questionId, this.answerId});

  factory VoteModel.fromJson(Map<String, dynamic> json) =>
      _$VoteModelFromJson(json);
  Map<String, dynamic> toJson() => _$VoteModelToJson(this);
}
