import 'package:logging/logging.dart';
import 'package:reff/core/providers/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class ReffSharedPreferences {
  final logger = Logger("ReffSharedPreferences");
  static const _kDEVICE_ID = "device_id";
  static const _kAGE = "age";
  static const _kLOCATION = "location";
  static const _kGENDER = "gender";

  Future<String> getDeviceID() async {
    final prefs = await SharedPreferences.getInstance();
    String value;
    if (prefs.containsKey(_kDEVICE_ID)) {
      value = prefs.getString(_kDEVICE_ID);
    } else {
      await setDeviceID(generateUniqueDeviceID());
      await prefs.reload();
      value = prefs.getString(_kDEVICE_ID);
    }
    logger.info("getDeviceUD : $value");
    return value;
  }

  Future<void> setDeviceID(String value) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_kDEVICE_ID)) {
      await prefs.setString(_kDEVICE_ID, value);
      logger.info("setDeviceID : $value");
    }
  }

  Future<void> setAge(int value) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_kAGE)) {
      await prefs.setInt(_kAGE, value);
      logger.info("setAge : $value");
    }
  }

  Future<int> getAge() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_kAGE)) {
      final value = prefs.getInt(_kAGE);
      logger.info("getAge : $value");
      return value;
    } else {
      return 0;
    }
  }

  Future<void> setLocation(String value) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_kLOCATION)) {
      await prefs.setString(_kLOCATION, value);
      logger.info("setLocation : $value");
    }
  }

  Future<String> getLocation() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_kLOCATION)) {
      final value = prefs.getString(_kLOCATION);
      logger.info("getLocation : $value");
      return value;
    } else {
      return "NONE";
    }
  }

  Future<void> setGender(Gender value) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_kGENDER)) {
      await prefs.setString(_kGENDER, value.toString());
      logger.info("setGender : $value");
    }
  }

  Future<Gender> getGender() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_kGENDER)) {
      final value = prefs.getString(_kGENDER);
      logger.info("getLocation : $value");
      return value == "Gender.Male" ? Gender.MALE : Gender.FEMALE;
    } else {
      return Gender.NONE;
    }
  }

  String generateUniqueDeviceID() => Uuid().v4();

  Future<void> clear() async {
    (await SharedPreferences.getInstance()).clear();
    logger.info("clear shared preferences");
  }
}
