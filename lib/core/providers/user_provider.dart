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
  final ProviderReference ref;
  final _logger = Logger('UserProvider');

  UserState(this.ref)
      : super(UserModel(
            age: 32,
            gender: Gender.male,
            city: CityModel(
                countryCode: "tr",
                name: "İstanbul",
                utc: 3,
                langCode: "tr",
                countryName: 'Turkey'),
            createdDate: DateTime.now().millisecondsSinceEpoch));

  static final provider = StateNotifierProvider((ref) => UserState(ref));

  void initialize(UserModel user) {
    _logger.info('initialize $user');
    state = user;
  }

  Future<bool> create() async {
    ref.read(BusyState.provider).setBusy();

    _setTimeStamp();
    final userID = await locator<BaseUserApi>().createUser(state);
    final reffResult = await locator<ReffSharedPreferences>().setUserID(userID);

    if (userID != null && reffResult) {
      _logger.info(LogMessages.created(userID));
      state = await locator<BaseUserApi>().get(userID);
      ref.read(BusyState.provider).setNotBusy();
      return true;
    } else {
      _logger.shout(LogMessages.notCreated);
      ref.read(BusyState.provider).setNotBusy();
      return false;
    }
  }

  void setAge(int age) => state = state.copyWith.call(age: age);
  void setGender(Gender gender) => state = state.copyWith.call(gender: gender);
  void setLocation(CityModel city) {
    _logger.info("city changes : $city");
    state = state.copyWith.call(city: city);
  }

  void _setTimeStamp() => state =
      state.copyWith.call(createdDate: DateTime.now().millisecondsSinceEpoch);
}
