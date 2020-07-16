import 'package:flutter/foundation.dart';
import 'package:reff/core/services/reff_shared_preferences.dart';
import 'package:reff/core/utils/locator.dart';

class UserProvider with ChangeNotifier {
  ReffSharedPreferences reffPrefs;
  UserModel model;

  UserProvider({UserModel model}) {
    if (locator.isRegistered<ReffSharedPreferences>()) {
      reffPrefs = locator<ReffSharedPreferences>();
    }
    this.model = model ?? UserModel();
  }

  Future<void> loadData() async {
    this.model.deviceID = await reffPrefs.getDeviceID();
    this.model.age = 29 ?? 0;
    this.model.location = "Antalya" ?? "NONE";
    this.model.gender = Gender.MALE ?? Gender.NONE;
    notifyListeners();
  }
}

enum Gender { MALE, FEMALE, NONE }

class UserModel {
  String deviceID;
  int age;
  Gender gender;
  String location;
}
