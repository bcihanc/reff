import 'package:freezed_annotation/freezed_annotation.dart';

part 'VoteModel.freezed.dart';
part 'VoteModel.g.dart';

@freezed
abstract class VoteModel with _$VoteModel {
  factory VoteModel({
    @nullable String id,
    @required String userID,
    @required String questionID,
    @required String answerID,
  }) = _AnswerModel;

  factory VoteModel.fromJson(Map<String, dynamic> json) =>
      _$VoteModelFromJson(json);
}
