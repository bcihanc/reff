import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:reff/core/providers/user_provider.dart';
import 'package:reff/core/utils/locator.dart';
import 'package:reff_shared/core/models/models.dart';
import 'package:reff_shared/core/services/services.dart';

class QuestionCard extends HookWidget {
  final _logger = Logger("QuestionCard");

  @override
  Widget build(BuildContext context) {
    _logger.info("build");

    final questionApi = locator<BaseQuestionApi>();
    final userProvider = useProvider(userStateProvider.state);

    return Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder<List<QuestionModel>>(
            initialData: <QuestionModel>[],
            stream: questionApi.gets(dateTime: DateTime.now()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                snapshot.data.map((e) => print(e.header));
                return Column(
                  children: snapshot.data
                      .map((question) => _cardBuild(context, question))
                      .toList(),
                );
              }
              return Text('loading');
            }),
      ),
    );
  }
}

Widget _cardBuild(BuildContext context, QuestionModel question) {
  return OpenContainer(
    closedColor: Colors.transparent,
    openBuilder: (context, c) => _openQuestionWidget(question),
    closedBuilder: (context, c) => _closedQuestionWidget(question),
  );
}

_closedQuestionWidget(QuestionModel question) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Stack(children: [
      if (question?.imageUrl != null && question?.imageUrl != '')
        Container(
          height: 200,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/transparency.png',
              image: question.imageUrl,
              fit: BoxFit.fill,
            ),
          ),
        ),
      Container(
        height: 200,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 4),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Text(
                question.header,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 2,
                        offset: Offset(1, 1),
                      ),
                    ]),
              ),
            ),
            Expanded(child: Container()),
            Row(
              children: [
                IconButton(icon: Icon(Icons.thumb_up), onPressed: () {}),
                IconButton(icon: Icon(Icons.thumb_down), onPressed: () {}),
                IconButton(icon: Icon(Icons.share), onPressed: () {}),
                Expanded(child: Container()),
                Chip(
                    backgroundColor: Colors.blue.withOpacity(0.5),
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.timelapse),
                        VerticalDivider(
                          color: Colors.transparent,
                          width: 8,
                        ),
                        Text(() {
                          final computedTime =
                              question.endDate.difference(DateTime.now());
                          return computedTime.inHours.toString();
                        }())
                      ],
                    )),
              ],
            ),
          ]),
        ),
      ),
    ]),
  );
}

_openQuestionWidget(QuestionModel question) {
  final answerApi = locator<BaseAnswerApi>();

  return Scaffold(
    appBar: AppBar(),
    body: FutureBuilder<List<AnswerModel>>(
      initialData: <AnswerModel>[],
      future: answerApi.gets(question.answers),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data.isNotEmpty) {
          final answers = snapshot.data;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  question.header,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                      onTap: () {
                        debugPrint('pick ${answer.id} ${answer.content}');
                        if (Navigator.canPop(context)) Navigator.pop(context);
                      },
                      child: Card(
                          color: answer.color.toColor(),
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
          return LinearProgressIndicator();
      },
    ),
  );
}
