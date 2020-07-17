import 'package:json_annotation/json_annotation.dart';

part 'QuestionModel.g.dart';

@JsonSerializable()
class QuestionModel {
  String id;
  final String header;
  final String content;
  final List<String> answers;
  final String imageUrl;
  final String timeStamp;

  QuestionModel(
      {this.header, this.content, this.answers, this.imageUrl, this.timeStamp});

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);
}
