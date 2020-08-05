import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:reff_shared/core/models/models.dart';

class UserProvider with ChangeNotifier {
  final _logger = Logger("UserProvider");

  UserModel user;

  UserProvider({this.user});

//  Future<void> reload(String id) async {
//    this.model = await api.user.get(id);
//    notifyListeners();
//    _logger.info("fetch complete");
//  }
}
