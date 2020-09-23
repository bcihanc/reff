import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:reff/core/providers/user_provider.dart';
import 'package:reff/core/services/reff_shared_preferences.dart';
import 'package:reff/core/utils/locator.dart';
import 'package:reff_shared/core/models/UserModel.dart';
import 'package:reff_shared/core/services/user_api.dart';

enum UserLocalApiState { userFound, userNotFound, connectivityProblem }

mixin UserLocalApi {
  static final _logger = Logger("UserLocalApi");

  static Future<UserLocalApiState> connectionAndUserCheck(
      BuildContext context) async {
    await Future.delayed(Duration(seconds: 0));

    final connectivity = await Connectivity().checkConnectivity();

    if (connectivity == ConnectivityResult.none) {
      return UserLocalApiState.connectivityProblem;
    } else {
      final userFromFirestore = await _tyrToFindUser();
      if (userFromFirestore != null) {
        context.refresh(UserState.provider).initializeUser(userFromFirestore);
        return UserLocalApiState.userFound;
      } else {
        return UserLocalApiState.userNotFound;
      }
    }
  }

  static Future<UserModel> _tyrToFindUser() async {
    final userID = await locator<ReffSharedPreferences>().getUserID();

    if (userID != null) {
      final user = await locator<BaseUserApi>().get(userID);
      if (user == null) {
        await locator<ReffSharedPreferences>().deleteUserID();
      }
      _logger.info('user found $user');
      return user;
    } else {
      _logger.shout('user not found');
      return null;
    }
  }
}
