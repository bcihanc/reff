import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:reff/core/models/QuestionModel.dart';
import 'package:reff/core/services/mock_api.dart';

class QuestionProvider with ChangeNotifier {
  final _logger = Logger("QuestionProvider");
  final ApiBase api;
  List<QuestionModel> models;

  QuestionProvider({this.models, this.api});

  Future<void> initialize(String id) async {
    this.models = await api.getQuestionsByUserID(id);
  }
}
