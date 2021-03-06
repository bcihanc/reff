import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:reff/core/utils/locator.dart';
import 'package:reff/views/page_views/question_pageview.dart';
import 'package:reff/views/page_views/shared_providers.dart';
import 'package:reff_shared/core/models/models.dart';
import 'package:reff_shared/core/services/services.dart';

final finishedAndAnsweredAndHaveResultQuestionsFutureProvider =
    FutureProvider<List<String>>((ref) async {
  final allQuestionIDsFuture =
      await ref.watch(allQuestionsIDsFutureProvider.future);

  final unansweredQuestionIDs = <String>[];
  for (final questionID in allQuestionIDsFuture) {
    final isHaveResult =
        await ref.watch(isHaveResultFutureProvider(questionID).future);
    if (isHaveResult) {
      unansweredQuestionIDs.add(questionID);
    }
  }
  return unansweredQuestionIDs;
});

final resultFutureProvider = FutureProvider.family<ResultModel, String>(
    (ref, questionID) async =>
        await locator<BaseResultApi>().getByQuestion(questionID));

class ArchivePageView extends HookWidget {
  const ArchivePageView();

  @override
  Widget build(BuildContext context) {
    final finishedAndAnsweredQuestionsFuture =
        useProvider(finishedAndAnsweredAndHaveResultQuestionsFutureProvider);

    return finishedAndAnsweredQuestionsFuture.when(
        data: (questionsIDs) {
          if (questionsIDs.isEmpty) {
            return Center(child: Text('Aktif herhangi bir sonuç yok :/'));
          }

          return Column(
              children: questionsIDs
                  .map((questionID) => QuestionAnswersFutureBuilder(
                        questionID: questionID,
                        builder: (context, data, _) {
                          return QuestionAndExpandableResult(
                              question: data.item1, answers: data.item2);
                        },
                      ))
                  .toList());
        },
        error: (error, stack) {
          debugPrint('$error');
          return Center(
            child: Text('$error'),
          );
        },
        loading: () => Center(
              child: SpinKitWave(color: Theme.of(context).accentColor),
            ));
  }
}

class QuestionAndExpandableResult extends HookWidget {
  const QuestionAndExpandableResult(
      {@required this.question, @required this.answers})
      : assert(question != null),
        assert(answers != null);

  final QuestionModel question;
  final List<AnswerModel> answers;

  @override
  Widget build(BuildContext context) {
    final result = useProvider(resultFutureProvider(question.id));
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        child: ExpansionTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(4)),
            child: CachedNetworkImage(
              fit: BoxFit.fitHeight,
              imageBuilder: (_, image) => Image(
                  height: 72, width: 72, fit: BoxFit.fitWidth, image: image),
              imageUrl: question?.imageUrl,
              errorWidget: (_, __, ___) => SizedBox.shrink(),
            ),
          ),
          tilePadding: const EdgeInsets.all(0),
          childrenPadding: const EdgeInsets.all(0),
          title: Text("${question.header}"),
          children: [
            result.when(
                data: (result) => ResultWithAnswersInfoBox(answers, result),
                error: (error, stack) {
                  debugPrint('$error');
                  return Center(
                    child: Text('$error'),
                  );
                },
                loading: () =>
                    SpinKitWave(color: Theme.of(context).accentColor))
          ],
        ),
      ),
    );
  }
}

class ResultWithAnswersInfoBox extends HookWidget {
  const ResultWithAnswersInfoBox(this.answers, this.result);

  final List<AnswerModel> answers;
  final ResultModel result;

  @override
  Widget build(BuildContext context) {
    final voteMapIterable = result.agesMap.map((answerID, ageMap) =>
        MapEntry(answerID, ageMap.values.toList() ?? <int>[]));

    final voteMap = voteMapIterable.map((key, value) {
      var counter = 0;
      if (value.isNotEmpty) {
        counter = counter + value.reduce((value, element) => value + element);
      }
      return MapEntry(key, counter);
    });

    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: answers.map((answer) {
          final vote = voteMap[answer.id];
          final allVotesCount = voteMap.values.reduce((a, b) => a + b);
          final ratio = 100 * vote ~/ allVotesCount;
          return Padding(
            padding: const EdgeInsets.all(4),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(MdiIcons.circle,
                                color: answer.color.toColor()),
                            const SizedBox(width: 8),
                            Text('${answer.content}'),
                          ],
                        ),
                      ),
                      Text('%$ratio')
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: ratio / 100,
                    valueColor: AlwaysStoppedAnimation(answer.color.toColor()),
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
