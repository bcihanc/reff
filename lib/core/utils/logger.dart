import 'package:logging/logging.dart';

void setupLogger() {
  Logger.root.level = Level.ALL;
  hierarchicalLoggingEnabled = true;
  Logger.root.onRecord.listen((record) =>
      print('${record.level.name}: ${record.loggerName}: ${record.message}'));
}
