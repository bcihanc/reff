import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:future_button/future_button.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:reff/core/providers/main_provider.dart';
import 'package:reff/core/providers/user_provider.dart';
import 'package:reff/core/utils/locator.dart';
import 'package:reff/views/page_views/shared_providers.dart';
import 'package:reff_shared/core/models/models.dart';
import 'package:reff_shared/core/services/services.dart';
import 'package:reff_shared/core/utils/time_cast.dart';
import 'package:tuple/tuple.dart';

final questionIDsData = <String>[];
final emptyListProvider = StateProvider<bool>((_) => false);

final unAnsweredQuestionIdsFutureProvider =
    FutureProvider.autoDispose<List<String>>((ref) async {
  final questionIDs =
      await ref.watch(allQuestionsIDsWithDateFilterFutureProvider.future);

  final unansweredQuestionIDs = <String>[];
  for (final questionID in questionIDs) {
    final isVoted = await ref.watch(isVotedFutureProvider(questionID).future);

    if (!isVoted) {
      unansweredQuestionIDs.add(questionID);
    }
  }
  if (unansweredQuestionIDs.isNotEmpty) {
    for (final questionID in unansweredQuestionIDs) {
      final isContain = questionIDsData.contains(questionID);

      if (!isContain) {
        questionIDsData.add(questionID);
      }
    }
  }
  return unansweredQuestionIDs;
});

final animatedListStateProvider =
    Provider((_) => GlobalKey<AnimatedListState>());

Widget _buildItemForAnimatedList(
    BuildContext context, String questionID, Animation animation) {
  return SizeTransition(
      sizeFactor: animation,
      axis: Axis.vertical,
      child: QuestionAnswersFutureBuilder(
        questionID: questionID,
        builder: (context, data, _) =>
            QuestionCard(question: data.item1, answers: data.item2),
      ));
}

class QuestionPageView extends HookWidget {
  QuestionPageView();

  final _logger = Logger("QuestionPageView");

  @override
  Widget build(BuildContext context) {
    _logger.info("build");

    final animatedListState = useProvider(animatedListStateProvider);
    final unAnsweredQuestionIds =
        useProvider(unAnsweredQuestionIdsFutureProvider);

    final listIsEmpty = useProvider(emptyListProvider).state;

    return unAnsweredQuestionIds.when(
        data: (questionIDs) {
          if (questionIDs.isEmpty || listIsEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(MdiIcons.chat, size: 64),
                  Divider(color: Colors.transparent),
                  Text('Şu an için gündemde bir şey yok.')
                ],
              ),
            );
          }

          return AnimatedList(
              key: animatedListState,
              initialItemCount: questionIDsData.length,
              itemBuilder: (context, index, animation) =>
                  _buildItemForAnimatedList(
                      context, questionIDsData[index], animation));
        },
        loading: () => Center(
              child: SpinKitWave(color: Theme.of(context).accentColor),
            ),
        error: (error, stack) {
          debugPrint('$error');
          return Center(
            child: Text('$error'),
          );
        });
  }
}

class QuestionAnswersFutureBuilder extends HookWidget {
  const QuestionAnswersFutureBuilder(
      {@required this.questionID, this.builder, this.child})
      : assert(questionID != null);

  final String questionID;
  final ValueWidgetBuilder<Tuple2<QuestionModel, List<AnswerModel>>> builder;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final questionAndAnswersFuture =
        useProvider(questionAndAnswersFutureProvider(questionID));

    return questionAndAnswersFuture.when(
        data: (data) => builder(context, data, child),
        error: (error, stack) {
          debugPrint('$error');
          return Center(
            child: Text('$error'),
          );
        },
        loading: () => SizedBox.shrink());
  }
}

class QuestionCard extends HookWidget {
  const QuestionCard({@required this.question, @required this.answers})
      : assert(question != null),
        assert(answers != null);

  final QuestionModel question;
  final List<AnswerModel> answers;

  @override
  Widget build(BuildContext context) {
    final animatedListState = useProvider(animatedListStateProvider);
    final user = useProvider(UserState.provider.state);

    void _onHandleTapAnswer(AnswerModel answer) async {
      final vote = VoteModel(
          userID: user.id,
          questionID: question.id,
          answerID: answer.id,
          city: user.city,
          age: user.calculatedAge,
          gender: user.gender,
          education: user.education,
          createdDate: DateTime.now().millisecondsSinceEpoch);

      context.read(BusyState.provider).setBusy();

      await locator<BaseVoteApi>().add(vote);
      context.read(BusyState.provider).setNotBusy();

      final indexOfRemovedIndex = questionIDsData.indexOf(question.id);
      animatedListState.currentState.removeItem(
          indexOfRemovedIndex,
          (context, animation) =>
              _buildItemForAnimatedList(context, question.id, animation),
          duration: Duration(milliseconds: 500));

      final isContain = questionIDsData.contains(question.id);
      if (isContain) {
        questionIDsData.remove(question.id);
      }

      if (questionIDsData.isEmpty) {
        context.refresh(emptyListProvider).state = true;
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        // elevation: 3,
        // shadowColor: Theme.of(context).accentColor,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(4)),
                      child: CachedNetworkImage(
                        imageUrl: question?.imageUrl,
                        width: MediaQuery.of(context).size.width,
                        imageBuilder: (_, image) => Image(
                            height: 140, fit: BoxFit.fitWidth, image: image),
                        errorWidget: (_, __, ___) => SizedBox.shrink(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomBadge(
                            label: question.city.name,
                            iconData: Icons.place,
                          ),
                          VerticalDivider(width: 4),
                          CustomBadge(
                            label: TimeCast.castToTranslate(
                                (question.endDate -
                                        DateTime.now()
                                            .millisecondsSinceEpoch) ~/
                                    (1000 * 60),
                                TimeCast(
                                    now: tr("now"),
                                    min: tr("min"),
                                    hour: tr("hour"),
                                    day: tr("day"),
                                    month: tr("month"))),
                            iconData: Icons.timelapse,
                          ),
                        ],
                      ),
                    ),
                  ]),
                  Container(
                      padding: const EdgeInsets.all(16) +
                          const EdgeInsets.only(top: 8),
                      alignment: Alignment.center,
                      child: Text(
                        "${question.header}",
                        style: TextStyle(fontSize: 18),
                      )),
                ],
              ),
              Divider(
                  indent: 32,
                  endIndent: 32,
                  height: 8,
                  color: Theme.of(context).accentColor),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnswersList(
                    answers: answers, onTapAnswer: _onHandleTapAnswer),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AnswersList extends HookWidget {
  const AnswersList({@required this.answers, this.onTapAnswer})
      : assert(answers != null);

  final List<AnswerModel> answers;
  final ValueChanged<AnswerModel> onTapAnswer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: answers
          .map((answer) => AnswerInkwell(
              key: Key(answer.id),
              color: answer.color.toColor(),
              label: answer.content,
              onTap: () => onTapAnswer(answer)))
          .toList(),
    );
  }
}

class CustomBadge extends HookWidget {
  const CustomBadge(
      {this.color, @required this.label, @required this.iconData});

  final Color color;
  final String label;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Badge(
        badgeColor: color ?? Theme.of(context).cardColor.withOpacity(0.8),
        elevation: 0,
        shape: BadgeShape.square,
        borderRadius: 6,
        toAnimate: false,
        badgeContent: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            children: [
              Icon(iconData, size: 14),
              const SizedBox(width: 4),
              Text("$label", style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}

class AnswerInkwell extends HookWidget {
  const AnswerInkwell(
      {@required Key key,
      @required this.color,
      @required this.label,
      this.onTap})
      : assert(label != null),
        assert(color != null),
        super(key: key);

  final Color color;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isBusy = useProvider(BusyState.provider.state);
    final isTapped = useState(false);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          isTapped.value
              ? Icon(MdiIcons.circle, color: color)
              : Icon(MdiIcons.circleOutline, color: color),
          Expanded(
            child: FutureFlatButton(
                progressIndicatorBuilder: (_) =>
                    SpinKitWave(color: color, size: 24),
                splashColor: color,
                progressIndicatorLocation: ProgressIndicatorLocation.center,
                onPressed: isBusy
                    ? null
                    : () async {
                        isTapped.value = true;
                        await onTap();
                      },
                child: Align(
                    alignment: Alignment.centerLeft, child: Text('$label'))),
          ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        splashColor: color,
        onTap: !isBusy ? onTap : null,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            Icon(MdiIcons.circleOutline, color: color),
            VerticalDivider(),
            Expanded(child: Text('${label}'))
          ]),
        ),
      ),
    );
  }
}
