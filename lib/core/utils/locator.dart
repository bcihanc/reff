import 'package:get_it/get_it.dart';
import 'package:reff/core/services/reff_shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerSingleton<ReffSharedPreferences>(ReffSharedPreferences());

  await getIt.allReady();
}
