// import 'dart:ui';
//
// import 'package:animations/animations.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_shimmer/flutter_shimmer.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:logging/logging.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:reff/core/providers/user_provider.dart';
// import 'package:reff/core/utils/locator.dart';
// import 'package:reff/views/widgets/custom_app_bar.dart';
// import 'package:reff/views/widgets/result_container.dart';
// import 'package:reff_shared/core/models/models.dart';
// import 'package:reff_shared/core/services/services.dart';
// import 'package:reff_shared/core/utils/time_cast.dart';
// import 'package:tuple/tuple.dart';
//
// class QuestionList extends HookWidget {
//   final _logger = Logger("QuestionList");
//
//   @override
//   Widget build(BuildContext context) {
//     _logger.info("build");
//
//     final questionApi = locator<BaseQuestionApi>();
//     final user = useProvider(UserState.provider.state);
//
//     return StreamBuilder<List<QuestionModel>>(
//         initialData: <QuestionModel>[],
//         stream: questionApi.getsSnapshots(
//           afterDateTime: DateTime.now(),
//           onlyActiveQuestions: true,
//           city: user.city,
//         ),
//         builder: (context, snapshot) {
//           if (snapshot.hasData && snapshot.data.isNotEmpty) {
//             final questions = snapshot.data;
//             final filteredStartDateTime = questions.dateTimeCorrection();
//
//             return ListView.builder(
//                 itemCount: filteredStartDateTime.length,
//                 shrinkWrap: true,
//                 itemBuilder: (context, index) {
//                   final question = filteredStartDateTime[index];
//                   return _cardBuild(context, question);
//                 });
//           }
//           // data is not ready
//           return Column(
//               children: List.generate(3, (index) => ProfileShimmer()));
//         });
//   }
//
//   Widget _cardBuild(BuildContext context, QuestionModel question) {
//     return OpenContainer(
//       closedColor: Theme.of(context).scaffoldBackgroundColor,
//       openBuilder: (context, c) => OpenQuestionContainer(question: question),
//       closedBuilder: (context, c) =>
//           _closedQuestionContainer(context, question),
//     );
//   }
//
//   Widget _closedQuestionContainer(
//       BuildContext context, QuestionModel question) {
//     return Padding(
//       key: Key(question.id),
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         child: Card(
//           child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                   if (question?.imageUrl != null && question?.imageUrl != '')
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(25.0),
//                           child: CachedNetworkImage(
//                             fit: BoxFit.cover,
//                             width: 50,
//                             height: 50,
//                             imageUrl: question?.imageUrl,
//                           ),
//                         ),
//                       ),
//                     Expanded(
//                       child: Container(
//                         padding: const EdgeInsets.all(8),
//                         child: Text(question.header,
//                             style: Theme.of(context).textTheme.headline1),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Divider(),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Icon(MdiIcons.mapMarker, size: 18),
//                           VerticalDivider(width: 4),
//                           Text(
//                             '${question.city.name}',
//                             style: Theme.of(context).textTheme.subtitle1,
//                           )
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Icon(MdiIcons.timer, size: 18),
//                           VerticalDivider(width: 4),
//                           Text(
//                             () {
//                               return TimeCast.castToTranslate(
//                                   (question.endDate -
//                                           DateTime.now()
//                                               .millisecondsSinceEpoch) ~/
//                                       (1000 * 60),
//                                   TimeCast(
//                                       now: tr("now"),
//                                       min: tr("min"),
//                                       hour: tr("hour"),
//                                       day: tr("day"),
//                                       month: tr("month")));
//                             }(),
//                             style: Theme.of(context).textTheme.subtitle1,
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ]),
//         ),
//       ),
//     );
//   }
// }
//
// final isVotedThisFutureProvider = FutureProvider.family
//     .autoDispose<bool, Tuple2<String, String>>(
//         (ref, userIDAndQuestionID) async {
//   debugPrint('isVotedThisFutureProvider');
//   return await locator<BaseUserApi>().isVotedThisQuestion(
//       userIDAndQuestionID.item1, userIDAndQuestionID.item2);
// });
//
// class OpenQuestionContainer extends HookWidget {
//   const OpenQuestionContainer({@required this.question});
//   final QuestionModel question;
//
//   @override
//   Widget build(BuildContext context) {
//     final answerApi = locator<BaseAnswerApi>();
//     final voteApi = locator<BaseVoteApi>();
//
//     final user = useProvider(UserState.provider.state);
//     final isVotedThisQuestionFuture =
//         useProvider(isVotedThisFutureProvider(Tuple2(user.id, question.id)));
//
//     _showQuestion() => Scaffold(
//           appBar: CustomAppBar(),
//           body: FutureBuilder<List<AnswerModel>>(
//             initialData: <AnswerModel>[],
//             future: answerApi.gets(question.answers),
//             builder: (context, snapshot) {
//               if (snapshot.hasData && snapshot.data.isNotEmpty) {
//                 final answers = snapshot.data;
//                 return SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       if (question?.imageUrl != null &&
//                           question?.imageUrl != '')
//                         Center(
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: CachedNetworkImage(
//                               imageUrl: question.imageUrl,
//                               height: 300,
//                               alignment: Alignment.center,
//                             ),
//                           ),
//                         ),
//                       Divider(),
//                       Center(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(question.header,
//                               style: TextStyle(fontSize: 17)),
//                         ),
//                       ),
//                       Divider(),
//                       ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: answers.length,
//                         itemBuilder: (context, index) {
//                           final answer = answers[index];
//                           return Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 8.0),
//                             child: InkWell(
//                               splashColor: answer.color.toColor(),
//                               borderRadius: BorderRadius.circular(8),
//                               onTap: () async {
//                                 final vote = VoteModel(
//                                     userID: user.id,
//                                     questionID: question.id,
//                                     answerID: answer.id,
//                                     city: user.city,
//                                     age: user.calculatedAge,
//                                     gender: user.gender,
//                                     education: user.education,
//                                     createdDate:
//                                       DateTime.now().millisecondsSinceEpoch);
//                                 await voteApi.add(vote);
//                                 if (Navigator.canPop(context)) {
//                                   Navigator.pop(context);
//                                 }
//                               },
//                               child: Card(
//                                   child: Padding(
//                                 padding: const EdgeInsets.all(12.0),
//                                 child: Row(
//                                   children: [
//                                     Icon(MdiIcons.circleOutline,
//                                         color: answer.color.toColor()),
//                                     VerticalDivider(width: 8),
//                                     Text(
//                                       "${answer.content}" ??
//                                           "answer content null",
//                                     ),
//                                   ],
//                                 ),
//                               )),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 );
//               } else {
//                 return Column(
//                   children: List.generate(1, (index) => ListTileShimmer()));
//               }
//             },
//           ),
//         );
//
//     _showResultIfReady() => Scaffold(
//         appBar: AppBar(), body: ResultContainer(questionID: question.id));
//
//     return Scaffold(
//       body: Center(
//           child: isVotedThisQuestionFuture.maybeWhen(
//               data: (isVotedBefore) =>
//                   isVotedBefore ? _showResultIfReady() : _showQuestion(),
//               orElse: () => SizedBox.shrink())),
//     );
//   }
// }
