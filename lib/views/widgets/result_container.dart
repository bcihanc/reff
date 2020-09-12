import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reff/core/utils/locator.dart';
import 'package:reff/views/page_views/archive_pageview.dart';
import 'package:reff_shared/core/models/models.dart';
import 'package:reff_shared/core/services/services.dart';

final questionDataFutureProvider = FutureProvider.family<QuestionModel, String>(
    (ref, questionID) => locator<BaseQuestionApi>().get(questionID));

final resultDataFutureProvider = FutureProvider.family<ResultModel, String>(
    (ref, questionID) => locator<BaseResultApi>().getByQuestion(questionID));

final answersDataFutureProvider =
    FutureProvider.family<List<AnswerModel>, String>((ref, questionID) =>
        locator<BaseAnswerApi>().getsByQuestion(questionID));

class ResultContainer extends HookWidget {
  final String questionID;

  const ResultContainer({@required this.questionID});

  @override
  Widget build(BuildContext context) {
    final questionData = useProvider(questionDataFutureProvider(questionID));
    final resultData = useProvider(resultDataFutureProvider(questionID));
    final answerData = useProvider(answersDataFutureProvider(questionID));

    return questionData.maybeWhen(
        data: (question) => Column(
              children: [
                ResultQuestionInfoBox(question),
                Divider(),
                resultData.maybeWhen(
                    data: (result) {
                      if (result != null) {
                        return answerData.maybeWhen(
                            data: (answers) =>
                                ResultWithAnswersInfoBox(answers, result),
                            orElse: () => SizedBox.shrink());
                      } else {
                        return Text('Sonuçlar bekleniyor...');
                      }
                    },
                    orElse: () => SizedBox.shrink())
              ],
            ),
        orElse: () => SizedBox.shrink());
  }
}

class ResultQuestionInfoBox extends HookWidget {
  const ResultQuestionInfoBox(this.question);

  final QuestionModel question;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text('${question.header}'),
    );
  }
}
