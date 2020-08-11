import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:reff/core/services/reff_shared_preferences.dart';
import 'package:reff/core/utils/locator.dart';
import 'package:reff_shared/core/models/CityModel.dart';
import 'package:reff_shared/core/models/models.dart';
import 'package:reff_shared/core/services/services.dart';
import 'package:state_notifier/state_notifier.dart';

class UserState extends StateNotifier<UserModel> {
  final _logger = Logger("UserProvider");
  UserState()
      : super(UserModel(
            age: 32,
            gender: Gender.MALE,
            city: CityModel.TURKEY.first,
            timeStamp: DateTime.now()));

  void initialize(UserModel user) => this.state = user;
  UserModel get user => state;

  Future<void> create() async {
    _setTimeStamp();
    final userID = await locator<BaseUserApi>().createUser(this.state);
    await locator<ReffSharedPreferences>().setUserID(userID);
    _logger.info("user created");
  }

  void setAge(int age) => state = state.copyWith.call(age: age);
  void setGender(Gender gender) => state = state.copyWith.call(gender: gender);
  void setLocation(CityModel city) => state = state.copyWith.call(city: city);
  void _setTimeStamp() =>
      state = state.copyWith.call(timeStamp: DateTime.now());
}

final userStateProvider = StateNotifierProvider((ref) => UserState());
