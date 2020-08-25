import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:reff/core/providers/user_provider.dart';
import 'package:reff/core/utils/locator.dart';
import 'package:reff_shared/core/models/models.dart';
import 'package:reff_shared/core/services/services.dart';

final uiUpdater = ValueNotifier(false);

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
      floatingActionButton: FloatingActionButton(
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
          }),
      body: SingleChildScrollView(
        child: ValueListenableBuilder(
          valueListenable: uiUpdater,
          builder: (context, value, child) {
            return StreamBuilder<List<QuestionModel>>(
                stream: questionApi.getsByUserUnAnswered(user),
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
      closedBuilder: (context, c) => _closedQuestionWidget(question),
    );
  }

  _closedQuestionWidget(QuestionModel question) {
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
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: (question?.imageUrl != null &&
                                question?.imageUrl != '')
                            ? NetworkImage(question?.imageUrl)
                            : null,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          question.header,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            MdiIcons.timer,
                            color: Colors.grey,
                          ),
                          VerticalDivider(width: 4),
                          Text(() {
                            final computedTime = question.endDate
                                .toDateTime()
                                .difference(DateTime.now());
                            return computedTime.inHours.toString() + " h";
                          }(), style: TextStyle(color: Colors.grey))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            MdiIcons.mapMarker,
                            color: Colors.grey,
                          ),
                          VerticalDivider(width: 4),
                          Text(
                            '${question.city.name}',
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                    VerticalDivider()
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}

class OpenQuestionContainer extends HookWidget {
  const OpenQuestionContainer({@required this.question});

  final QuestionModel question;

  @override
  Widget build(BuildContext context) {
    final answerApi = locator<BaseAnswerApi>();
    final user = useProvider(UserState.provider.state);

    final voteApi = locator<BaseVoteApi>();

    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<AnswerModel>>(
        initialData: <AnswerModel>[],
        future: answerApi.gets(question.answers),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data.isNotEmpty) {
            final answers = snapshot.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
//                if (question?.imageUrl != null && question?.imageUrl != '')
//                  Container(
//                    height: 200,
//                    child: ClipRRect(
//                      borderRadius: BorderRadius.all(Radius.circular(8)),
//                      child: FadeInImage.assetNetwork(
//                        placeholder: 'assets/images/transparency.png',
//                        image: question.imageUrl,
//                        fit: BoxFit.fill,
//                      ),
//                    ),
//                  ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                  child: Text(
                    question.header,
                    style: TextStyle(fontSize: 17),
                  ),
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
                          debugPrint('pick ${answer.id} ${answer.content}');
                          final vote = VoteModel(
                              userID: user.id,
                              questionID: question.id,
                              answerID: answer.id,
                              createdDate:
                                  DateTime.now().millisecondsSinceEpoch);

                          await voteApi.add(vote);
                          uiUpdater.value = !uiUpdater.value;
                          if (Navigator.canPop(context)) Navigator.pop(context);
                        },
                        child: Card(
                            color: answer.color.toColor().withOpacity(0.4),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                answer.content ?? "answer content null",
                              ),
                            )),
                      ),
                    );
                  },
                ),
              ],
            );
          } else
            return Column(
                children: List.generate(1, (index) => ListTileShimmer()));
        },
      ),
    );
  }
}
