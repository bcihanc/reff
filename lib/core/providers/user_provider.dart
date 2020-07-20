import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:reff_shared/core/models/models.dart';
import 'package:reff_shared/core/services/services.dart';

class UserProvider with ChangeNotifier {
  final _logger = Logger("UserProvider");
  final ApiBase api;
  UserModel model;

  UserProvider({this.model, this.api});

  Future<void> reload(String id) async {
    this.model = await api.getUserByID(id);
    notifyListeners();
    _logger.info("fetch complete");
  }
}
