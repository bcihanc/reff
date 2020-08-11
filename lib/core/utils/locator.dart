import 'package:get_it/get_it.dart';
import 'package:reff/core/services/firebase_api.dart';
import 'package:reff/core/services/reff_shared_preferences.dart';
import 'package:reff_shared/core/services/services.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingleton<ReffSharedPreferences>(ReffSharedPreferences());

  locator.registerLazySingleton<BaseQuestionApi>(() => QuestionFirestoreApi());
  locator.registerLazySingleton<BaseAnswerApi>(() => AnswerFirestoreApi());
  locator.registerLazySingleton<BaseUserApi>(() => UserFirebaseApi());
  locator.registerLazySingleton<BaseVoteApi>(() => VoteFirebaseApi());

//  locator.registerLazySingleton<BaseApi>(() => FirestoreApi());

  await locator.allReady();
}
