import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class ColorJsonConverter implements JsonConverter<Color, String> {
  const ColorJsonConverter();

  @override
  Color fromJson(String json) {
    final persedColor = int.tryParse(json, radix: 16);
    return persedColor == null ? null : Color(persedColor);
  }

  @override
  String toJson(Color object) {
    return object.value.toRadixString(16);
  }
}
