import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:reff/core/providers/user_provider.dart';
import 'package:reff/core/services/reff_shared_preferences.dart';
import 'package:reff/core/utils/locator.dart';
import 'package:reff/views/screens/register_screen.dart';
import 'package:reff_shared/core/models/models.dart';
import 'package:reff_shared/core/services/services.dart';
import 'package:reff_shared/core/utils/time_cast.dart';
import 'package:tuple/tuple.dart';

final uiUpdater = ValueNotifier(false);

final getsByUserUnAnsweredStreamProvider = StreamProvider.autoDispose
    .family<List<QuestionModel>, UserModel>((_, user) {
  return locator<BaseQuestionApi>().getsByUserUnAnswered(user);
});

class QuestionList extends HookWidget {
  final _logger = Logger("QuestionList");

  @override
  Widget build(BuildContext context) {
    _logger.info("build");

    final questionApi = locator<BaseQuestionApi>();

    final voteApi = locator<BaseVoteApi>();
    final user = useProvider(UserState.provider.state);

    return Scaffold(
      appBar: AppBar(
          title: Text(
        'r.e.f.f.',
        style: GoogleFonts.pacifico(),
      )),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
              heroTag: 'deleteUser',
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.delete),
                  Text('user', style: TextStyle(fontSize: 8))
                ],
              ),
              onPressed: () async {
                await locator<ReffSharedPreferences>().clear();
                await locator<BaseUserApi>().remove(user.id);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()));
              }),
          Container(height: 10, width: 0),
          FloatingActionButton(
              heroTag: 'deleteVotes',
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.delete),
                  Text(
                    'votes',
                    style: TextStyle(fontSize: 8),
                  )
                ],
              ),
              onPressed: () async {
                await voteApi.removeAllByUserID(user.id);
                uiUpdater.value = !uiUpdater.value;
                context.refresh(getsByUserUnAnsweredStreamProvider(user));
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: ValueListenableBuilder(
          valueListenable: uiUpdater,
          builder: (context, value, child) {
            return StreamBuilder<List<QuestionModel>>(
                initialData: <QuestionModel>[],
                stream: questionApi.gets(
                  dateTime: DateTime.now(),
                  onlyActiveQuestions: true,
                  cityName: user.city,
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final questions = snapshot.data;
                    return ListView.builder(
                        itemCount: questions.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final question = questions[index];
                          return _cardBuild(context, question);
                        });
                  }
                  return Column(
                      children: List.generate(3, (index) => ProfileShimmer()));
                });
          },
        ),
      ),
    );
  }

  Widget _cardBuild(BuildContext context, QuestionModel question) {
    return OpenContainer(
      closedColor: Theme.of(context).scaffoldBackgroundColor,
      openBuilder: (context, c) => OpenQuestionContainer(
        question: question,
      ),
      closedBuilder: (context, c) => _closedQuestionWidget(context, question),
    );
  }

  Widget _closedQuestionWidget(BuildContext context, QuestionModel question) {
    return Padding(
      key: Key(question.id),
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Card(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (question?.imageUrl != null && question?.imageUrl != '')
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/images/transparency.png',
                            fit: BoxFit.cover,
                            width: 50,
                            height: 50,
                            image: question?.imageUrl,
                          ),
                        ),
                      ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Text(question.header,
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline1),
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(MdiIcons.mapMarker, size: 18),
                          VerticalDivider(width: 4),
                          Text(
                            '${question.city.name}',
                            style: Theme
                                .of(context)
                                .textTheme
                                .subtitle1,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(MdiIcons.timer, size: 18),
                          VerticalDivider(width: 4),
                          Text(
                                () {
                              return TimeCast.castToTranslate(
                                  (question.endDate -
                                      DateTime
                                          .now()
                                          .millisecondsSinceEpoch) ~/
                                      (1000 * 60),
                                  TimeCast(
                                      now: tr("now"),
                                      min: tr("min"),
                                      hour: tr("hour"),
                                      day: tr("day"),
                                      month: tr("month")));
                            }(),
                            style: Theme
                                .of(context)
                                .textTheme
                                .subtitle1,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}

final isVotedThisFutureProvider = FutureProvider.family
    .autoDispose<bool, Tuple2<String, String>>((ref, userAndQuestion) async {
  debugPrint('isVotedThisFutureProvider');
  return await locator<BaseUserApi>()
      .isVotedThisQuestion(userAndQuestion.item1, userAndQuestion.item2);
});

class OpenQuestionContainer extends HookWidget {
  const OpenQuestionContainer({@required this.question});
  final QuestionModel question;

  @override
  Widget build(BuildContext context) {
    final answerApi = locator<BaseAnswerApi>();
    final voteApi = locator<BaseVoteApi>();

    final user = useProvider(UserState.provider.state);
    final isVotedThisQuestionFuture =
    useProvider(isVotedThisFutureProvider(Tuple2(user.id, question.id)));

    _showQuestion() => Scaffold(
          appBar: AppBar(
            title: Text(
              'r.e.f.f',
              style: GoogleFonts.pacifico(),
            ),
          ),
          body: FutureBuilder<List<AnswerModel>>(
            initialData: <AnswerModel>[],
            future: answerApi.gets(question.answers),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data.isNotEmpty) {
                final answers = snapshot.data;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (question?.imageUrl != null && question?.imageUrl != '')
                      Container(
                        alignment: Alignment.center,
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/transparency.png',
                          image: question.imageUrl,
                          height: 300,
                          width: double.maxFinite,
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 18),
                      child:
                      Text(question.header, style: TextStyle(fontSize: 17)),
                    ),
                    Divider(),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: answers.length,
                      itemBuilder: (context, index) {
                        final answer = answers[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: GestureDetector(
                            onTap: () async {
                              final vote = VoteModel(
                                  userID: user.id,
                                  questionID: question.id,
                                  answerID: answer.id,
                                  city: user.city,
                                  age: user.calculatedAge,
                                  gender: user.gender,
                                  education: user.education,
                                  createdDate:
                                  DateTime
                                      .now()
                                      .millisecondsSinceEpoch);
                              await voteApi.add(vote);
                              uiUpdater.value = !uiUpdater.value;
                              if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              }
                            },
                            child: Card(
                                color: answer.color.toColor().withOpacity(0.4),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "${answer.content}" ??
                                        "answer content null",
                                  ),
                                )),
                          ),
                        );
                      },
                    ),
                  ],
                );
              } else {
                return Column(
                    children: List.generate(1, (index) => ListTileShimmer()));
              }
            },
          ),
        );

    _showResultIfReady() => Scaffold(
        appBar: AppBar(),
        body: SafeArea(child: ResultWidget(questionID: question.id)));

    return Scaffold(
      body: Center(
          child: isVotedThisQuestionFuture.maybeWhen(
              data: (data) => data ? _showResultIfReady() : _showQuestion(),
              orElse: () => CircularProgressIndicator())),
    );
  }
}

class ResultWidget extends HookWidget {
  final String questionID;

  const ResultWidget({@required this.questionID});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ResultModel>(
      future: locator<BaseResultApi>().getByQuestion(questionID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final result = snapshot.data;
          if (result != null) {
            return Text(result.toString());
          } else {
            return Center(
                child: Text(
                    ' Bu soru için oy kullanmıştın, sonuçlar bekleniyor...'));
          }
        } else {
          return LinearProgressIndicator();
        }
      },
    );
  }
}

class ResultWidgetHolder extends HookWidget {
  const ResultWidgetHolder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card();
  }
}
