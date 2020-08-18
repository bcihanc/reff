import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:reff/core/services/reff_shared_preferences.dart';
import 'package:reff/core/utils/locator.dart';
import 'package:reff_shared/core/models/CityModel.dart';
import 'package:reff_shared/core/models/models.dart';
import 'package:reff_shared/core/services/services.dart';
import 'package:reff_shared/core/utils/log_messages.dart';
import 'package:state_notifier/state_notifier.dart';

class UserState extends StateNotifier<UserModel> {
  final _logger = Logger("UserProvider");
  UserState()
      : super(UserModel(
            age: 32,
            gender: Gender.MALE,
            city: CityModel(
                countryCode: "tr", name: "İstanbul", utc: 3, langCode: "tr"),
            timeStamp: DateTime.now()));

  void initialize(UserModel user) => this.state = user;
  UserModel get user => state;

  Future<bool> create() async {
    _setTimeStamp();
    final userID = await locator<BaseUserApi>().createUser(this.state);
    final reffResult = await locator<ReffSharedPreferences>().setUserID(userID);

    if (userID != null && reffResult) {
      _logger.info(LogMessages.created(userID));
      return true;
    } else {
      _logger.shout(LogMessages.notCreated);
      return false;
    }
  }

  void setAge(int age) => state = state.copyWith.call(age: age);
  void setGender(Gender gender) => state = state.copyWith.call(gender: gender);
  void setLocation(CityModel city) {
    _logger.info("city changes : $city");
    state = state.copyWith.call(city: city);
  }

  void _setTimeStamp() =>
      state = state.copyWith.call(timeStamp: DateTime.now());
}

final userStateProvider = StateNotifierProvider((ref) => UserState());
