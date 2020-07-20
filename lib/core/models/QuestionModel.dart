import 'package:freezed_annotation/freezed_annotation.dart';

part 'QuestionModel.freezed.dart';
part 'QuestionModel.g.dart';

@freezed
abstract class QuestionModel with _$QuestionModel {
  const factory QuestionModel({
    @nullable String id,
    @required String header,
    @nullable String content,
    @nullable List<String> answers,
    String imageUrl,
    DateTime timeStamp,
  }) = _QuestionModel;

  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);
}
