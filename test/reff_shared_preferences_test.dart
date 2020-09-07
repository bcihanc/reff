import 'package:flutter_test/flutter_test.dart';
import 'package:reff/core/services/reff_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  final mockData = {
    ReffSharedPreferences.userIDKey: ReffSharedPreferences.userIDValue
  };

  ReffSharedPreferences prefs;

  group("reff shared preferenceses tests", () {
    setUpAll(() async {
      prefs = ReffSharedPreferences();
    });

    test("userID key varsa", () async {
      SharedPreferences.setMockInitialValues(mockData);

      final userID = await prefs.getUserID();
      expect(userID, ReffSharedPreferences.userIDValue);
    });

    test("userID key yoksa", () async {
      SharedPreferences.setMockInitialValues({});

      final userID = await prefs.getUserID();
      expect(userID, null);
    });

    test("userID kayıt", () async {
      SharedPreferences.setMockInitialValues({});

      final result = await prefs.setUserID(ReffSharedPreferences.userIDValue);
      expect(result, true);

      final userID = await prefs.getUserID();
      expect(userID, ReffSharedPreferences.userIDValue);
    });

    test("clean kontrol", () async {
      SharedPreferences.setMockInitialValues(mockData);

      final result = await prefs.clear();
      expect(result, true);
    });
  });
}
