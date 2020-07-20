import 'package:get_it/get_it.dart';
import 'package:reff/core/models/UserModel.dart';
import 'package:reff/core/providers/user_provider.dart';
import 'package:reff/core/services/mock_api.dart';
import 'package:reff/core/services/reff_shared_preferences.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingleton<ReffSharedPreferences>(ReffSharedPreferences());
  locator.registerSingleton<MockApi>(MockApi());

  locator.registerFactoryParam<UserProvider, UserModel, ApiBase>(
      (UserModel param1, ApiBase param2) =>
          UserProvider(model: param1, api: param2));

//  locator.registerFactoryParam<QuestionProvider, List<QuestionModel>, ApiBase>(
//      (List<QuestionModel> param1, ApiBase param2) =>
//          QuestionProvider(models: param1, api: param2));
//
//  locator.registerFactoryParam<QuestionProvider, List<QuestionModel>, ApiBase>(
//      (List<QuestionModel> param1, ApiBase param2) =>
//          QuestionProvider(models: param1, api: param2));

  await locator.allReady();
}
