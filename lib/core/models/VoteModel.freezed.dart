// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'VoteModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
VoteModel _$VoteModelFromJson(Map<String, dynamic> json) {
  return _AnswerModel.fromJson(json);
}

class _$VoteModelTearOff {
  const _$VoteModelTearOff();

// ignore: unused_element
  _AnswerModel call(
      {@nullable String id,
      @required String userID,
      @required String questionID,
      @required String answerID}) {
    return _AnswerModel(
      id: id,
      userID: userID,
      questionID: questionID,
      answerID: answerID,
    );
  }
}

// ignore: unused_element
const $VoteModel = _$VoteModelTearOff();

mixin _$VoteModel {
  @nullable
  String get id;
  String get userID;
  String get questionID;
  String get answerID;

  Map<String, dynamic> toJson();
  $VoteModelCopyWith<VoteModel> get copyWith;
}

abstract class $VoteModelCopyWith<$Res> {
  factory $VoteModelCopyWith(VoteModel value, $Res Function(VoteModel) then) =
      _$VoteModelCopyWithImpl<$Res>;
  $Res call(
      {@nullable String id, String userID, String questionID, String answerID});
}

class _$VoteModelCopyWithImpl<$Res> implements $VoteModelCopyWith<$Res> {
  _$VoteModelCopyWithImpl(this._value, this._then);

  final VoteModel _value;
  // ignore: unused_field
  final $Res Function(VoteModel) _then;

  @override
  $Res call({
    Object id = freezed,
    Object userID = freezed,
    Object questionID = freezed,
    Object answerID = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      userID: userID == freezed ? _value.userID : userID as String,
      questionID:
          questionID == freezed ? _value.questionID : questionID as String,
      answerID: answerID == freezed ? _value.answerID : answerID as String,
    ));
  }
}

abstract class _$AnswerModelCopyWith<$Res> implements $VoteModelCopyWith<$Res> {
  factory _$AnswerModelCopyWith(
          _AnswerModel value, $Res Function(_AnswerModel) then) =
      __$AnswerModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {@nullable String id, String userID, String questionID, String answerID});
}

class __$AnswerModelCopyWithImpl<$Res> extends _$VoteModelCopyWithImpl<$Res>
    implements _$AnswerModelCopyWith<$Res> {
  __$AnswerModelCopyWithImpl(
      _AnswerModel _value, $Res Function(_AnswerModel) _then)
      : super(_value, (v) => _then(v as _AnswerModel));

  @override
  _AnswerModel get _value => super._value as _AnswerModel;

  @override
  $Res call({
    Object id = freezed,
    Object userID = freezed,
    Object questionID = freezed,
    Object answerID = freezed,
  }) {
    return _then(_AnswerModel(
      id: id == freezed ? _value.id : id as String,
      userID: userID == freezed ? _value.userID : userID as String,
      questionID:
          questionID == freezed ? _value.questionID : questionID as String,
      answerID: answerID == freezed ? _value.answerID : answerID as String,
    ));
  }
}

@JsonSerializable()
class _$_AnswerModel implements _AnswerModel {
  const _$_AnswerModel(
      {@nullable this.id,
      @required this.userID,
      @required this.questionID,
      @required this.answerID})
      : assert(userID != null),
        assert(questionID != null),
        assert(answerID != null);

  factory _$_AnswerModel.fromJson(Map<String, dynamic> json) =>
      _$_$_AnswerModelFromJson(json);

  @override
  @nullable
  final String id;
  @override
  final String userID;
  @override
  final String questionID;
  @override
  final String answerID;

  @override
  String toString() {
    return 'VoteModel(id: $id, userID: $userID, questionID: $questionID, answerID: $answerID)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AnswerModel &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.userID, userID) ||
                const DeepCollectionEquality().equals(other.userID, userID)) &&
            (identical(other.questionID, questionID) ||
                const DeepCollectionEquality()
                    .equals(other.questionID, questionID)) &&
            (identical(other.answerID, answerID) ||
                const DeepCollectionEquality()
                    .equals(other.answerID, answerID)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(userID) ^
      const DeepCollectionEquality().hash(questionID) ^
      const DeepCollectionEquality().hash(answerID);

  @override
  _$AnswerModelCopyWith<_AnswerModel> get copyWith =>
      __$AnswerModelCopyWithImpl<_AnswerModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_AnswerModelToJson(this);
  }
}

abstract class _AnswerModel implements VoteModel {
  const factory _AnswerModel(
      {@nullable String id,
      @required String userID,
      @required String questionID,
      @required String answerID}) = _$_AnswerModel;

  factory _AnswerModel.fromJson(Map<String, dynamic> json) =
      _$_AnswerModel.fromJson;

  @override
  @nullable
  String get id;
  @override
  String get userID;
  @override
  String get questionID;
  @override
  String get answerID;
  @override
  _$AnswerModelCopyWith<_AnswerModel> get copyWith;
}
