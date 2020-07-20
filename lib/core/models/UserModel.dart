import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'UserModel.freezed.dart';
part 'UserModel.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    @nullable String id,
    @required int age,
    @required Gender gender,
    @required String location,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

enum Gender { MALE, FEMALE }
