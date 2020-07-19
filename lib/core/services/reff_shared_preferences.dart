import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReffSharedPreferences {
  final logger = Logger("ReffSharedPreferences");
  static const kuserIDKey = "userID";

  Future<bool> isUserExist() async {
    final prefs = await SharedPreferences.getInstance();
    final exist = prefs.containsKey(kuserIDKey);
    logger.info("isUserExist : $exist");
    return exist;
  }

  Future<String> getUserID() async {
    final prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(kuserIDKey);
    logger.info("getDeviceUD : $value");
    return value;
  }

//  Future<void> setUserID(String value) async {
//    final prefs = await SharedPreferences.getInstance();
//    if (!prefs.containsKey(_kuserID)) {
//      await prefs.setString(_kuserID, value);
//      logger.info("setDeviceID : $value");
//    }
//  }

//  String generateUniqueDeviceID() => Uuid().v4();

  Future<void> clear() async {
    (await SharedPreferences.getInstance()).clear();
    logger.info("clear shared preferences");
  }
}
