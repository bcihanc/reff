import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReffSharedPreferences {
  final _logger = Logger("ReffSharedPreferences");
  static const userIDKey = "userID";

  Future<bool> isRegistered() async {
    final exist =
        (await SharedPreferences.getInstance()).containsKey(userIDKey);
    _logger.info("registered : $exist");
    return exist;
  }

  Future<String> getUserID() async {
    final value = (await SharedPreferences.getInstance()).getString(userIDKey);
    _logger.info("getUserUD : $value");
    return value;
  }

  Future<bool> setUserID(String value) async {
    final result = await (await SharedPreferences.getInstance())
        .setString(userIDKey, value);
    _logger.info("setUserID : $value");
    return result;
  }

  Future<void> clear() async {
    (await SharedPreferences.getInstance()).clear();
    _logger.info("clear shared preferences");
  }
}
