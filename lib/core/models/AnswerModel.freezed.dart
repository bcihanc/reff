// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'AnswerModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
AnswerModel _$AnswerModelFromJson(Map<String, dynamic> json) {
  return _AnswerModel.fromJson(json);
}

class _$AnswerModelTearOff {
  const _$AnswerModelTearOff();

// ignore: unused_element
  _AnswerModel call(
      {@nullable String id,
      @required String content,
      @nullable String imageUrl}) {
    return _AnswerModel(
      id: id,
      content: content,
      imageUrl: imageUrl,
    );
  }
}

// ignore: unused_element
const $AnswerModel = _$AnswerModelTearOff();

mixin _$AnswerModel {
  @nullable
  String get id;
  String get content;
  @nullable
  String get imageUrl;

  Map<String, dynamic> toJson();
  $AnswerModelCopyWith<AnswerModel> get copyWith;
}

abstract class $AnswerModelCopyWith<$Res> {
  factory $AnswerModelCopyWith(
          AnswerModel value, $Res Function(AnswerModel) then) =
      _$AnswerModelCopyWithImpl<$Res>;
  $Res call({@nullable String id, String content, @nullable String imageUrl});
}

class _$AnswerModelCopyWithImpl<$Res> implements $AnswerModelCopyWith<$Res> {
  _$AnswerModelCopyWithImpl(this._value, this._then);

  final AnswerModel _value;
  // ignore: unused_field
  final $Res Function(AnswerModel) _then;

  @override
  $Res call({
    Object id = freezed,
    Object content = freezed,
    Object imageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      content: content == freezed ? _value.content : content as String,
      imageUrl: imageUrl == freezed ? _value.imageUrl : imageUrl as String,
    ));
  }
}

abstract class _$AnswerModelCopyWith<$Res>
    implements $AnswerModelCopyWith<$Res> {
  factory _$AnswerModelCopyWith(
          _AnswerModel value, $Res Function(_AnswerModel) then) =
      __$AnswerModelCopyWithImpl<$Res>;
  @override
  $Res call({@nullable String id, String content, @nullable String imageUrl});
}

class __$AnswerModelCopyWithImpl<$Res> extends _$AnswerModelCopyWithImpl<$Res>
    implements _$AnswerModelCopyWith<$Res> {
  __$AnswerModelCopyWithImpl(
      _AnswerModel _value, $Res Function(_AnswerModel) _then)
      : super(_value, (v) => _then(v as _AnswerModel));

  @override
  _AnswerModel get _value => super._value as _AnswerModel;

  @override
  $Res call({
    Object id = freezed,
    Object content = freezed,
    Object imageUrl = freezed,
  }) {
    return _then(_AnswerModel(
      id: id == freezed ? _value.id : id as String,
      content: content == freezed ? _value.content : content as String,
      imageUrl: imageUrl == freezed ? _value.imageUrl : imageUrl as String,
    ));
  }
}

@JsonSerializable()
class _$_AnswerModel implements _AnswerModel {
  _$_AnswerModel(
      {@nullable this.id, @required this.content, @nullable this.imageUrl})
      : assert(content != null);

  factory _$_AnswerModel.fromJson(Map<String, dynamic> json) =>
      _$_$_AnswerModelFromJson(json);

  @override
  @nullable
  final String id;
  @override
  final String content;
  @override
  @nullable
  final String imageUrl;

  @override
  String toString() {
    return 'AnswerModel(id: $id, content: $content, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AnswerModel &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.content, content) ||
                const DeepCollectionEquality()
                    .equals(other.content, content)) &&
            (identical(other.imageUrl, imageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.imageUrl, imageUrl)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(content) ^
      const DeepCollectionEquality().hash(imageUrl);

  @override
  _$AnswerModelCopyWith<_AnswerModel> get copyWith =>
      __$AnswerModelCopyWithImpl<_AnswerModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_AnswerModelToJson(this);
  }
}

abstract class _AnswerModel implements AnswerModel {
  factory _AnswerModel(
      {@nullable String id,
      @required String content,
      @nullable String imageUrl}) = _$_AnswerModel;

  factory _AnswerModel.fromJson(Map<String, dynamic> json) =
      _$_AnswerModel.fromJson;

  @override
  @nullable
  String get id;
  @override
  String get content;
  @override
  @nullable
  String get imageUrl;
  @override
  _$AnswerModelCopyWith<_AnswerModel> get copyWith;
}
