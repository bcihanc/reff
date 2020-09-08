import 'package:flutter/foundation.dart' show debugPrint;
import 'package:logging/logging.dart';

void setupLogger() {
  Logger.root.level = Level.ALL;
  hierarchicalLoggingEnabled = true;
  Logger.root.onRecord.listen((record) => debugPrint(
      '${record.level.name}: ${record.loggerName}: ${record.message}'));
}
