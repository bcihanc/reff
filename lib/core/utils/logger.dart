import 'package:logging/logging.dart';

void logger() {
  Logger.root.level = Level.ALL;
  hierarchicalLoggingEnabled = true;
  Logger.root.onRecord.listen((record) =>
      print('${record.level.name}: ${record.loggerName}: ${record.message}'));
}
