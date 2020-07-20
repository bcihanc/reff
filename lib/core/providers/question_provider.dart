import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:reff_shared/core/models/models.dart';
import 'package:reff_shared/core/services/services.dart';

class QuestionProvider with ChangeNotifier {
  final _logger = Logger("QuestionProvider");
  final ApiBase api;
  List<QuestionModel> models;

  QuestionProvider({this.models, this.api});
}

class AnswerProvider with ChangeNotifier {
  final _logger = Logger("AnswerProvider");
  final ApiBase api;
  List<AnswerProvider> models;

  AnswerProvider({this.models, this.api});
}
