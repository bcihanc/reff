import 'package:flutter_test/flutter_test.dart';
import 'package:reff/core/services/reff_shared_preferences.dart';
import 'package:reff/core/utils/locator.dart';
import 'package:reff/core/utils/mock_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  await setupLocator();

  group("userID varsa", () {
    ReffSharedPreferences reffSharedPreferences;
    setUpAll(() {
      SharedPreferences.setMockInitialValues(
          {ReffSharedPreferences.kuserIDKey: kuserID});
      reffSharedPreferences = locator<ReffSharedPreferences>();
    });

    test("alınan değer, mock değere eşit olmalı", () async {
      final userID = await reffSharedPreferences.getUserID();
      expect(userID, equals(userID));
    });
  });

  group("diğer metodlar", () {
    ReffSharedPreferences reffSharedPreferences;
    setUpAll(() {
      reffSharedPreferences = locator<ReffSharedPreferences>();
    });

    test("tüm veriler temizlenmeli", () async {
      SharedPreferences.setMockInitialValues(
          {ReffSharedPreferences.kuserIDKey: kuserID});
      await reffSharedPreferences.clear();
      final length = (await SharedPreferences.getInstance()).getKeys().length;
      expect(length, 0);
    });
  });
}
