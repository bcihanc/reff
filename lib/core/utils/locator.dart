import 'package:get_it/get_it.dart';
import 'package:reff/core/models/UserModel.dart';
import 'package:reff/core/providers/user_provider.dart';
import 'package:reff/core/services/reff_shared_preferences.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingleton<ReffSharedPreferences>(ReffSharedPreferences());

  locator.registerFactoryParam<UserProvider, UserModel, void>(
      (UserModel param1, param2) => UserProvider(model: param1));

  await locator.allReady();
}
