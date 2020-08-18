import 'package:logging/logging.dart';
import 'package:reff_shared/core/utils/log_messages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReffSharedPreferences {
  final _logger = Logger("ReffSharedPreferences");
  static const userIDKey = "userID";
  static const userIDValue = "TdmoTWNiclrKmOFD6zAC";

  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  Future<String> getUserID() async {
    final isContains = (await _prefs).containsKey(userIDKey);

    if (isContains) {
      final value =
          (await SharedPreferences.getInstance()).getString(userIDKey);
      _logger.info("getUserUD : $value");
      return value;
    } else {
      _logger.shout("getUserUD : is null");
      return null;
    }
  }

  Future<bool> setUserID(String value) async {
    final result = await (await _prefs).setString(userIDKey, value);

    result
        ? _logger.info(LogMessages.created(value))
        : _logger.shout(LogMessages.notCreated);

    return result;
  }

  Future<bool> clear() async {
    final result = await (await _prefs).clear();

    result
        ? _logger.info("prefs temizlendi")
        : _logger.shout("prefs temizlenemedi");
    return result;
  }
}
