// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'QuestionModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
QuestionModel _$QuestionModelFromJson(Map<String, dynamic> json) {
  return _QuestionModel.fromJson(json);
}

class _$QuestionModelTearOff {
  const _$QuestionModelTearOff();

// ignore: unused_element
  _QuestionModel call(
      {@nullable String id,
      @required String header,
      @nullable String content,
      @nullable List<String> answers,
      String imageUrl,
      DateTime timeStamp}) {
    return _QuestionModel(
      id: id,
      header: header,
      content: content,
      answers: answers,
      imageUrl: imageUrl,
      timeStamp: timeStamp,
    );
  }
}

// ignore: unused_element
const $QuestionModel = _$QuestionModelTearOff();

mixin _$QuestionModel {
  @nullable
  String get id;
  String get header;
  @nullable
  String get content;
  @nullable
  List<String> get answers;
  String get imageUrl;
  DateTime get timeStamp;

  Map<String, dynamic> toJson();
  $QuestionModelCopyWith<QuestionModel> get copyWith;
}

abstract class $QuestionModelCopyWith<$Res> {
  factory $QuestionModelCopyWith(
          QuestionModel value, $Res Function(QuestionModel) then) =
      _$QuestionModelCopyWithImpl<$Res>;
  $Res call(
      {@nullable String id,
      String header,
      @nullable String content,
      @nullable List<String> answers,
      String imageUrl,
      DateTime timeStamp});
}

class _$QuestionModelCopyWithImpl<$Res>
    implements $QuestionModelCopyWith<$Res> {
  _$QuestionModelCopyWithImpl(this._value, this._then);

  final QuestionModel _value;
  // ignore: unused_field
  final $Res Function(QuestionModel) _then;

  @override
  $Res call({
    Object id = freezed,
    Object header = freezed,
    Object content = freezed,
    Object answers = freezed,
    Object imageUrl = freezed,
    Object timeStamp = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      header: header == freezed ? _value.header : header as String,
      content: content == freezed ? _value.content : content as String,
      answers: answers == freezed ? _value.answers : answers as List<String>,
      imageUrl: imageUrl == freezed ? _value.imageUrl : imageUrl as String,
      timeStamp:
          timeStamp == freezed ? _value.timeStamp : timeStamp as DateTime,
    ));
  }
}

abstract class _$QuestionModelCopyWith<$Res>
    implements $QuestionModelCopyWith<$Res> {
  factory _$QuestionModelCopyWith(
          _QuestionModel value, $Res Function(_QuestionModel) then) =
      __$QuestionModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {@nullable String id,
      String header,
      @nullable String content,
      @nullable List<String> answers,
      String imageUrl,
      DateTime timeStamp});
}

class __$QuestionModelCopyWithImpl<$Res>
    extends _$QuestionModelCopyWithImpl<$Res>
    implements _$QuestionModelCopyWith<$Res> {
  __$QuestionModelCopyWithImpl(
      _QuestionModel _value, $Res Function(_QuestionModel) _then)
      : super(_value, (v) => _then(v as _QuestionModel));

  @override
  _QuestionModel get _value => super._value as _QuestionModel;

  @override
  $Res call({
    Object id = freezed,
    Object header = freezed,
    Object content = freezed,
    Object answers = freezed,
    Object imageUrl = freezed,
    Object timeStamp = freezed,
  }) {
    return _then(_QuestionModel(
      id: id == freezed ? _value.id : id as String,
      header: header == freezed ? _value.header : header as String,
      content: content == freezed ? _value.content : content as String,
      answers: answers == freezed ? _value.answers : answers as List<String>,
      imageUrl: imageUrl == freezed ? _value.imageUrl : imageUrl as String,
      timeStamp:
          timeStamp == freezed ? _value.timeStamp : timeStamp as DateTime,
    ));
  }
}

@JsonSerializable()
class _$_QuestionModel implements _QuestionModel {
  _$_QuestionModel(
      {@nullable this.id,
      @required this.header,
      @nullable this.content,
      @nullable this.answers,
      this.imageUrl,
      this.timeStamp})
      : assert(header != null);

  factory _$_QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$_$_QuestionModelFromJson(json);

  @override
  @nullable
  final String id;
  @override
  final String header;
  @override
  @nullable
  final String content;
  @override
  @nullable
  final List<String> answers;
  @override
  final String imageUrl;
  @override
  final DateTime timeStamp;

  @override
  String toString() {
    return 'QuestionModel(id: $id, header: $header, content: $content, answers: $answers, imageUrl: $imageUrl, timeStamp: $timeStamp)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _QuestionModel &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.header, header) ||
                const DeepCollectionEquality().equals(other.header, header)) &&
            (identical(other.content, content) ||
                const DeepCollectionEquality()
                    .equals(other.content, content)) &&
            (identical(other.answers, answers) ||
                const DeepCollectionEquality()
                    .equals(other.answers, answers)) &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)) &&
            (identical(other.timeStamp, timeStamp) ||
                const DeepCollectionEquality()
                    .equals(other.timeStamp, timeStamp)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(header) ^
      const DeepCollectionEquality().hash(content) ^
      const DeepCollectionEquality().hash(answers) ^
      const DeepCollectionEquality().hash(imageUrl) ^
      const DeepCollectionEquality().hash(timeStamp);

  @override
  _$QuestionModelCopyWith<_QuestionModel> get copyWith =>
      __$QuestionModelCopyWithImpl<_QuestionModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_QuestionModelToJson(this);
  }
}

abstract class _QuestionModel implements QuestionModel {
  factory _QuestionModel(
      {@nullable String id,
      @required String header,
      @nullable String content,
      @nullable List<String> answers,
      String imageUrl,
      DateTime timeStamp}) = _$_QuestionModel;

  factory _QuestionModel.fromJson(Map<String, dynamic> json) =
      _$_QuestionModel.fromJson;

  @override
  @nullable
  String get id;
  @override
  String get header;
  @override
  @nullable
  String get content;
  @override
  @nullable
  List<String> get answers;
  @override
  String get imageUrl;
  @override
  DateTime get timeStamp;
  @override
  _$QuestionModelCopyWith<_QuestionModel> get copyWith;
}
