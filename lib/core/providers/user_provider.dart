import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:reff/core/providers/main_provider.dart';
import 'package:reff/core/services/reff_shared_preferences.dart';
import 'package:reff/core/utils/locator.dart';
import 'package:reff_shared/core/models/CityModel.dart';
import 'package:reff_shared/core/models/models.dart';
import 'package:reff_shared/core/services/services.dart';
import 'package:reff_shared/core/utils/log_messages.dart';
import 'package:state_notifier/state_notifier.dart';

class UserState extends StateNotifier<UserModel> {
  final Reader reader;
  final _logger = Logger('UserProvider');

  UserState(this.reader) : super(UserModel.initial);

  static final provider = StateNotifierProvider((ref) => UserState(ref.read));

  void initializeUser(UserModel user) {
    _logger.info('initialize $user');
    state = user;
  }

  Future<bool> create() async {
    reader(BusyState.provider).setBusy();

    _setTimeStamp();
    final userID = await locator<BaseUserApi>().add(state);
    final reffResult = await locator<ReffSharedPreferences>().setUserID(userID);

    if (userID != null && reffResult) {
      _logger.info(LogMessages.created(userID));
      state = await locator<BaseUserApi>().get(userID);
      reader(BusyState.provider).setNotBusy();
      return true;
    } else {
      _logger.shout(LogMessages.notCreated);
      reader(BusyState.provider).setNotBusy();
      return false;
    }
  }

  void setAge(int age) => state = state.copyWith.call(age: age);

  void setEducation(Education education) =>
      state = state.copyWith.call(education: education);

  void setGender(Gender gender) => state = state.copyWith.call(gender: gender);

  void setCity(CityModel city) {
    _logger.info("city changes : $city");
    state = state.copyWith.call(city: city);
  }

  void _setTimeStamp() => state =
      state.copyWith.call(createdDate: DateTime.now().millisecondsSinceEpoch);

  Future<bool> deleteUser() async {
    reader(BusyState.provider).setBusy();
    final resultDeleteFirebase = await locator<BaseUserApi>().remove(state.id);
    final resultDeleteSP =
        await locator<ReffSharedPreferences>().deleteUserID();
    state = UserModel.initial;
    reader(BusyState.provider).setNotBusy();

    return resultDeleteSP && resultDeleteFirebase;
  }
}
