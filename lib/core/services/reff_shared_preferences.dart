import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class ReffSharedPreferences {
  final logger = Logger("ReffSharedPreferences");
  static const _kDEVICE_ID = "device_id";

  Future<String> getDeviceID() async {
    final prefs = await SharedPreferences.getInstance();
    String deviceID;
    if (prefs.containsKey(_kDEVICE_ID)) {
      deviceID = prefs.getString(_kDEVICE_ID);
    } else {
      await setDeviceID(await generateUniqueDeviceID());
      await prefs.reload();
      deviceID = prefs.getString(_kDEVICE_ID);
    }
    return deviceID;
  }

  Future<void> setDeviceID(String value) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_kDEVICE_ID)) {
      await prefs.setString(_kDEVICE_ID, value);
      logger.info("setDeviceID : $value");
    }
  }

  Future<String> generateUniqueDeviceID() async {
    String uniqueId;
    final deviceInfo = DeviceInfoPlugin();
    final uuid = Uuid().v4();

    if (Platform.isAndroid) {
      final info = await deviceInfo.androidInfo;
      if (info != null && info.androidId != null) {
        uniqueId = info.androidId;
      } else {
        uniqueId = uuid;
      }
    } else if (Platform.isIOS) {
      final info = await deviceInfo.iosInfo;
      if (info != null && info.identifierForVendor != null) {
        uniqueId = info.identifierForVendor;
      } else {
        uniqueId = uuid;
      }
    } else {
      uniqueId = uuid;
    }

    logger.info("generateUniqueID : $uniqueId");
    return uniqueId;
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    logger.info("clear shared preferences");
  }
}
