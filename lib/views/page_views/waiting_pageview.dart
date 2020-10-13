import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reff/views/page_views/question_pageview.dart';
import 'package:reff/views/page_views/shared_providers.dart';
import 'package:reff_shared/core/models/models.dart';
import 'package:reff_shared/core/utils/time_cast.dart';

class WaitingPageView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final questions = useProvider(allQuestionsIDsWithDateFilterFutureProvider);

    return questions.when(
        data: (questionsIDs) => Column(
              children: questionsIDs
                  .map((questionID) => WaitingQuestionContainer(
                        questionID: questionID,
                      ))
                  .toList(),
            ),
        error: (error, stack) {
          debugPrint('$error');
          return Center(
            child: Text('$error'),
          );
        },
        loading: () =>
            Center(child: SpinKitWave(color: Theme.of(context).accentColor)));
  }
}

class WaitingQuestionContainer extends HookWidget {
  WaitingQuestionContainer({@required this.questionID})
      : assert(questionID != null);

  final String questionID;

  Widget _buildQuestionAndRemaningTime(QuestionModel question) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
          child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(4)),
            child: CachedNetworkImage(
              imageBuilder: (_, image) =>
                  Image(height: 72, width: 72, fit: BoxFit.fill, image: image),
              imageUrl: question?.imageUrl,
              errorWidget: (_, __, ___) => SizedBox.shrink(),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text('${question.header}')),
          const SizedBox(width: 10),
          CustomBadge(
            label: TimeCast.castToTranslate(
                (question.endDate - DateTime.now().millisecondsSinceEpoch) ~/
                    (1000 * 60),
                TimeCast(
                    now: tr("now"),
                    min: tr("min"),
                    hour: tr("hour"),
                    day: tr("day"),
                    month: tr("month"))),
            iconData: Icons.timelapse,
          )
        ],
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QuestionAnswersFutureBuilder(
        questionID: questionID,
        builder: (context, data, _) {
          final question = data.item1;
          return _buildQuestionAndRemaningTime(question);
        });
  }
}
