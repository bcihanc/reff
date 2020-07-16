import 'package:flutter_test/flutter_test.dart';
import 'package:reff/core/services/reff_shared_preferences.dart';
import 'package:reff/core/utils/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  setupLocator();
  const deviceID = "3f937f2c-a12e-41af-8cd6-3d3325419fa4";

  group("deviceID varsa", () {
    ReffSharedPreferences reffSharedPreferences;
    setUp(() {
      SharedPreferences.setMockInitialValues({"device_id": deviceID});
      reffSharedPreferences = getIt<ReffSharedPreferences>();
    });
    test("alınan değer, mock değere eşit olmalı", () async {
      final deviceID = await reffSharedPreferences.getDeviceID();
      expect(deviceID, equals(deviceID));
    });

    test("yeni bir deviceID varolanın üstüne yazılmamalı", () async {
      final newDeviceID = "86271112-2425-4767-8f2f-3d410d55fd68";
      await reffSharedPreferences.setDeviceID(newDeviceID);
      final deviceID = await reffSharedPreferences.getDeviceID();
      expect(deviceID, isNot(equals(newDeviceID)));
    });
  });

  group("deviceID yoksa", () {
    ReffSharedPreferences reffSharedPreferences;
    setUp(() {
      SharedPreferences.setMockInitialValues({});
      reffSharedPreferences = getIt<ReffSharedPreferences>();
    });
    test("getDeviceID yeni bir değer yaratmalı ve onu geriye döndürmeli",
        () async {
      final deviceID = await reffSharedPreferences.getDeviceID();
      expect(deviceID, isNotNull);
    });
  });

  group("diğer metodlar", () {
    ReffSharedPreferences reffSharedPreferences;
    setUp(() {
      reffSharedPreferences = getIt<ReffSharedPreferences>();
    });

    test("getUniqeID asla null döndürmemeli", () {
      final deviceID = reffSharedPreferences.generateUniqueDeviceID();
      expect(deviceID, isNotNull);
    });
  });
}
