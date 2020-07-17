import 'package:json_annotation/json_annotation.dart';

part 'UserModel.g.dart';

@JsonSerializable()
class UserModel {
  String id;
  final String deviceID;
  final int age;
  final Gender gender;
  final String location;

  UserModel({this.deviceID, this.age, this.gender, this.location});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

enum Gender { MALE, FEMALE, NONE }
