import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reff/core/providers/user_provider.dart';
import 'package:reff/core/utils/locator.dart';
import 'package:reff_shared/core/models/models.dart';
import 'package:reff_shared/core/services/services.dart';
import 'package:tuple/tuple.dart';

final questionPoolProvider =
    Provider<List<QuestionModel>>((_) => <QuestionModel>[]);

final answersPoolProvider = Provider<List<AnswerModel>>((_) => <AnswerModel>[]);

/// zaman filteresiz
final allQuestionsIDsFutureProvider = FutureProvider<List<String>>((ref) async {
  final user = ref.watch(UserState.provider.state);
  final questions = await locator<BaseQuestionApi>()
      .gets(city: user.city, onlyActiveQuestions: true);

  for (final question in questions) {
    final isContain = ref.read(questionPoolProvider).contains(question);
    if (!isContain) {
      ref.read(questionPoolProvider).add(question);
    }
  }

  return questions.map((question) => question.id).toList();
});

/// zaman filtreli
final allQuestionsIDsWithDateFilterFutureProvider =
    FutureProvider<List<String>>((ref) async {
  final user = ref.watch(UserState.provider.state);
  final questions = await locator<BaseQuestionApi>().gets(
      city: user.city,
      limit: 10,
      onlyActiveQuestions: true,
      afterDateTime: DateTime.now());

  for (final question in questions) {
    final isContain = ref.read(questionPoolProvider).contains(question);
    if (!isContain) {
      ref.read(questionPoolProvider).add(question);
    }
  }

  return questions.map((question) => question.id).toList();
});

final questionAndAnswersFutureProvider =
    FutureProvider.family<Tuple2<QuestionModel, List<AnswerModel>>, String>(
        (ref, questionID) async {
  final question =
      await ref.read(_getQuestionByIDFutureProvider(questionID).future);
  final answers =
      await ref.read(_getAnswersByQuestionIDFutureProvider(questionID).future);
  return Tuple2(question, answers);
});

final isVotedFutureProvider =
    FutureProvider.autoDispose.family<bool, String>((ref, questionID) async {
  final user = ref.watch(UserState.provider.state);
  return await locator<BaseUserApi>().isVotedThisQuestion(user.id, questionID);
});

final isHaveResultFutureProvider =
    FutureProvider.family<bool, String>((ref, questionID) async {
  return await locator<BaseResultApi>().isHaveResultByQuestionID(questionID);
});

final _getQuestionByIDFutureProvider =
    FutureProvider.family<QuestionModel, String>((ref, questionID) async {
  final questionPool = ref.read(questionPoolProvider);

  for (final question in questionPool) {
    if (questionID == question.id) {
      return question;
    }
  }

  return await locator<BaseQuestionApi>().get(questionID);
});

final _getAnswersByQuestionIDFutureProvider =
FutureProvider.family<List<AnswerModel>, String>((ref, questionID) async {
  return await locator<BaseAnswerApi>().getsByQuestion(questionID);
});
